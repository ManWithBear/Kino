//
//  MoviePreview.swift
//  Kino
//
//  Created by Denis Bogomolov on 28/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

struct MoviePreview: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case overview
        /// YYYY-MM-dd
        case released = "release_date"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdrop = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case averageVote = "vote_average"
    }
    let poster: String?
    let overview: String?
    let released: Date?
    let id: Int // here no reason to have movie without id
    let originalTitle: String?
    let originalLanguage: String?
    let title: String?
    let backdrop: String?
    let popularity: Float?
    let voteCount: Int?
    let video: Bool?
    let averageVote: Float?
}
