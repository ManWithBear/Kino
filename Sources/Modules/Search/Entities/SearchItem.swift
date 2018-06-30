//
//  SearchItem.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

/// One element to be displayed on search screen
///
/// - data: item coresponding to user search request
/// - loading: signal of list ending and need of loading next bunch of data
/// - error: search item that failed to load for some reason
enum SearchItem: Equatable {
    case data(SearchData)
    case loading
    case error(msg: String)
}
