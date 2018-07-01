//
//  Pager.swift
//  Kino
//
//  Created by Denis Bogomolov on 01/07/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation
import RxSwift

/// This component responsible for paginated loading of data
class Pager<Item: Codable> {
    typealias PagerDataSource = (Int) -> Single<Page<Item>>

    enum State {
        case initial
        case loading(oldData: [Page<Item>])
        case error(Error, oldData: [Page<Item>])
        case idle(data: [Page<Item>])
        case finished(data: [Page<Item>])
    }

    let stateStream = BehaviorSubject<State>(value: .initial)

    private let dataSource: PagerDataSource
    private let bag = DisposeBag()

    private var allPages: [Page<Item>] = []
    private var state: State = .initial {
        didSet {
            stateStream.onNext(state)
        }
    }

    init(_ dataSource: @escaping PagerDataSource) {
        self.dataSource = dataSource
    }

    /// Perform next page request if not in finished or already loading state
    func nextPage() {
        switch state {
        case .loading, .finished: return
        case .initial, .error, .idle: break
        }
        state = .loading(oldData: allPages)
        dataSource(allPages.count + 1)
            .subscribe(
                onSuccess: { [weak self] in self?.didLoad($0) },
                onError: { [weak self] in self?.fail(with: $0) }
            )
            .disposed(by: bag)
    }

    private func didLoad(_ page: Page<Item>) {
        let stateMaker = page.page == page.totalPages && page.page != nil ? State.finished : State.idle
        allPages.append(page)
        state = stateMaker(allPages)
    }

    private func fail(with error: Error) {
        state = .error(error, oldData: allPages)
    }
}
