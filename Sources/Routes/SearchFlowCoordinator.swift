//
//  SearchFlowCoordinator.swift
//  Kino
//
//  Created by Denis Bogomolov on 01/07/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit

protocol SearchFlowCoordinator: FlowCoordinator { }

class SearchFlowCoordinatorImpl {
    struct Dependencies {
        let searchFactory: SearchFactory
    }
    let deps: Dependencies

    init(_ deps: Dependencies) {
        self.deps = deps
    }

    func showDetail(for preview: Movie.Preview) {
        print("Did select item with title: \(preview.title ?? "<- No title ->")")
    }
}

extension SearchFlowCoordinatorImpl: SearchFlowCoordinator {
    func startFlow() -> UIViewController {
        let flow = SearchFlow(
            onItemSelection: { [weak self] in self?.showDetail(for: $0) }
        )
        return deps.searchFactory.make(with: flow)
    }
}
