//
//  Dummies.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation
import RxSwift

extension Movie.Preview {
    static let dummy = Movie.Preview(
       poster: "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
       overview: "When an unexpected enemy emerges and threatens global safety and security...",
       released: Date(),
       id: 24428,
       originalTitle: "The Avengers",
       originalLanguage: "en",
       title: "The Avengers",
       backdrop: "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
       popularity: 7.353212,
       voteCount: 8503,
       averageVote: 7.33
    )
}

class DummyMovieSearchProvider: MovieSearchProvider {
    let page: Page<Movie.Preview> = {
        return Page<Movie.Preview>(page: 1, results: [.dummy], totalResults: 0, totalPages: 1)
    }()

    func query(_ query: String, page: Int) -> Single<Page<Movie.Preview>> {
        return .just(self.page)
    }
}

class DummySearchViewModel: SearchViewModel {
    var searchStateStream: Observable<SearchState> {
        let items: [SearchItem] = [
            .data(SearchData(title: "My title")),
            .loading,
            .error(msg: "Here my error")
        ]
        return .just(.data(items: items))
    }

    func didChangeSearch(_ text: String) {
        print("\(#function) - \(text)")
    }

    func didCancel() {
        print("\(#function)")
    }

    func didSelectItem(at index: Int) {
        print("\(#function) - \(index)")
    }

    func loadData() {
        print("\(#function)")
    }

    func retryLoading() {
        print("\(#function)")
    }
}
