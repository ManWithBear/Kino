//
//  AssetCollection.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

struct AssetCollection: Codable, Equatable {
    typealias ID = Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case poster = "poster_path"
        case backdrop = "backdrop_path"
        case assets = "parts"
    }

    let id: ID
    let name: String?
    let overview: String?
    let poster: ImagePath?
    let backdrop: ImagePath?
    let assets: [Movie.Preview]?
}
