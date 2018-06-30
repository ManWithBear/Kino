//
//  Genre.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

struct Genre: Codable, Equatable {
    typealias ID = Int
    let id: ID
    let name: String?
}
