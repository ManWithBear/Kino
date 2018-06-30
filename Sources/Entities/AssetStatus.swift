//
//  AssetStatus.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

enum AssetStatus: String, Codable {
    case rumored = "Rumored"
    case planned = "Planned"
    case inProduction = "In Production"
    case posProduction = "Post Production"
    case released = "Released"
    case canceled = "Canceled"
}
