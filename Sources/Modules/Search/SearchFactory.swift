//
//  SearchFactory.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import UIKit

/// Factory that hides module implementation details and provide convinient way to initialize module
protocol SearchFactory {
    func make(with flow: SearchFlow) -> UIViewController
}

class SearchFactoryImpl {
    struct Dependencies {
        let search: MovieSearchProvider
    }
    let deps: Dependencies

    init(_ deps: Dependencies) {
        self.deps = deps
    }
}

extension SearchFactoryImpl: SearchFactory {
    func make(with flow: SearchFlow) -> UIViewController {
        let vmDeps = SearchViewModelImpl.Dependencies(search: deps.search)
        let viewModel = SearchViewModelImpl(flow, vmDeps)
        return SearchViewController(viewModel)
    }
}
