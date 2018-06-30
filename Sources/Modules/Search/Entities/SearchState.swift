//
//  SearchState.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

/// State fo search screen
///
/// - idle: user not searched anything yet
/// - loading: waiting for data
/// - data: list of searchItems to dispay for user
/// - error: some global error happend
enum SearchState: Equatable {
    case idle
    case loading
    case data(items: [SearchItem])
    case error(msg: String)
}
