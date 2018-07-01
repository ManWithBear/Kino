//
//  SearchViewModel.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchViewModel {
    var searchStateStream: PublishObservable<SearchState> { get }

    /// User have changed search query
    func didChangeSearch(_ text: String)

    /// User canceled search
    func didCancel()

    /// User select search item at `index`
    func didSelectItem(at index: Int)

    /// User is close to end of list
    func loadData()

    /// User wanted to restart failed loading
    func retryLoading()
}

class SearchViewModelImpl {

    struct Dependencies {
        let search: MovieSearchProvider
    }

    let deps: Dependencies
    let flow: SearchFlow

    let searchState = BehaviorSubject<SearchState>(value: .idle)
    let searchQuery = PublishSubject<String>()
    let bag = DisposeBag()

    private var pager: Pager<Movie.Preview>? {
        didSet {
            pager.map { self.subscribeToPager($0) }
        }
    }
    /// Items from last SearchState.
    /// Used for getting selected by user Movie preview
    private var recentPreviews: [Movie.Preview] = []

    init(_ flow: SearchFlow, _ deps: Dependencies) {
        self.flow = flow
        self.deps = deps
        subscribeToSearch()
    }

    func subscribeToSearch() {
        searchQuery
            .throttle(0.1, scheduler: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self, provider = deps.search] query in
                    guard !query.isEmpty else {
                        self?.pager = nil
                        self?.searchState.onNext(.idle)
                        return
                    }
                    self?.pager = Pager { provider.query(query, page: $0) }
                }
            )
            .disposed(by: bag)
    }

    func subscribeToPager(_ pager: Pager<Movie.Preview>) {
        pager.stateStream
            .toSearchState(
                pagesTransformer: { [weak self] pages in
                    guard let me = self else { return [] }
                    let filteredMovies = pages
                        .compactMap { $0.results }
                        .flatMap { $0 }
                        .filter { $0.title != nil }

                    me.recentPreviews = filteredMovies

                    return filteredMovies.compactMap { $0.title }
                        .map { SearchData(title: $0) }
                        .map { SearchItem.data($0) }
                },
                errorTransformer: { _ in
                    "Error happend. Tap to try again"
                }
            )
            .bind(to: searchState)
            .disposed(by: bag)

        pager.nextPage()
    }
}

extension SearchViewModelImpl: SearchViewModel {
    var searchStateStream: PublishObservable<SearchState> {
        return searchState
            .asObservable()
            .observeOn(MainScheduler.instance)
    }

    func didChangeSearch(_ text: String) {
        searchQuery.onNext(text)
    }

    func didCancel() {
        searchQuery.onNext("")
        searchState.onNext(.idle)
    }

    func didSelectItem(at index: Int) {
        guard index < recentPreviews.count else { return }
        let movie = recentPreviews[index]
        print("DidSelect: \(movie.title)")
    }

    func loadData() {
        pager?.nextPage()
    }

    func retryLoading() {
        pager?.nextPage()
    }
}

fileprivate extension Observable where Element == Pager<Movie.Preview>.State {
    fileprivate typealias PagesTransformer = ([Page<Movie.Preview>]) -> [SearchItem]
    fileprivate typealias ErrorTransformer = (Error?) -> String

    /// Transform state of page loader to search screen sate
    ///
    /// - Parameter messageFromError: Transfromer from Error to UI string
    func toSearchState(pagesTransformer: @escaping PagesTransformer, errorTransformer: @escaping ErrorTransformer) -> Observable<SearchState> {
        return map { state in
            switch state {
            case .initial: return .idle

            case let .loading(oldData: data) where data.isEmpty:
                return .loading

            case let .error(error, oldData: data) where data.isEmpty:
                return .error(msg: errorTransformer(error))

            case let .loading(oldData: data):
                let items = pagesTransformer(data) + [.loading]
                return .data(items: items)

            case let .error(error, oldData: data):
                let msg = errorTransformer(error)
                let items = pagesTransformer(data) + [.error(msg: msg)]
                return .data(items: items)

            case let .idle(data: data):
                let items = pagesTransformer(data) + [.loading]
                return .data(items: items)

            case let .finished(data: data):
                return .data(items: pagesTransformer(data))
            }
        }
    }
}
