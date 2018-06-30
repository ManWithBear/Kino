//
//  Company.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

enum Company {
    typealias ID = Int

    struct Preview: Codable, Equatable {
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case logo = "logo_path"
            case country = "origin_country"
        }
        let id: ID
        let name: String?
        let logo: ImagePath?
        let country: Country.ID?
    }

    /// Not implemented
    struct Detail: Codable, Equatable {
        let id: ID
    }
}
