//
//  SearchViewModel.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation
import RxSwift

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

    init(_ flow: SearchFlow, _ deps: Dependencies) {
        self.flow = flow
        self.deps = deps
    }
}

extension SearchViewModelImpl: SearchViewModel {
    var searchStateStream: PublishObservable<SearchState> { return .never() }

    func didChangeSearch(_ text: String) { }
    func didCancel() { }
    func didSelectItem(at index: Int) { }
    func loadData() { }
    func retryLoading() { }
}
