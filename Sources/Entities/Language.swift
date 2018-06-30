//
//  Language.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

struct Language: Codable, Equatable {
    typealias ID = String

    enum CodingKeys: String, CodingKey {
        case id = "iso_639_1"
        case name
    }

    let id: ID
    let name: String?
}
