//
//  Page.swift
//  Kino
//
//  Created by Denis Bogomolov on 28/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

struct Page<T: Codable>: Codable {

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

    let page: Int?
    let results: [T]?
    let totalResults: Int?
    let totalPages: Int?
}
