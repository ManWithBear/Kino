//
//  MovieSearchProvider.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation
import RxSwift

/// Service that able to perfrom search requests for movies
protocol MovieSearchProvider {
    /// Load `page` page for `query` string
    ///
    /// - Parameters:
    ///   - query: search string
    ///   - page: index of result page
    /// - Returns: Single observable that either return Page of Movie preview or error
    func query(_ query: String, page: Int) -> Single<Page<Movie.Preview>>
}
