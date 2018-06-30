//
//  Movie.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

enum Movie {
    typealias ID = Int

    struct Preview: Codable, Equatable {
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
            case averageVote = "vote_average"
        }

        let poster: ImagePath?
        let overview: String?
        let released: Date?
        let id: ID
        let originalTitle: String?
        let originalLanguage: Language.ID?
        let title: String?
        let backdrop: ImagePath?
        let popularity: Float?
        let voteCount: Int?
        let averageVote: Float?
    }

    struct Detail: Codable, Equatable {
        enum CodingKeys: String, CodingKey {
            case isAdult = "adult"
            case backdrop = "backdrop_path"
            case collections = "belongs_to_collection"
            case budget
            case genres
            case homepage
            case id
            case imdbID = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview
            case popularity
            case poster = "poster_path"
            case productionCompanies = "production_companies"
            case productionCountries = "production_countries"
            /// yyyy-MM-dd
            case released = "release_date"
            case revenue
            case duration = "runtime"
            case spokenLanguages = "spoken_languages"
            case status
            case tagline
            case title
            case averageVote = "vote_average"
            case voteCount = "vote_count"
        }

        let isAdult: Bool
        let backdrop: ImagePath?
        let collections: [AssetCollection]?
        let budget: Int
        let genres: [Genre]?
        let homepage: String?
        let id: ID
        let imdbID: String
        let originalLanguage: String?
        let originalTitle: String?
        let overview: String?
        let popularity: Float?
        let poster: ImagePath?
        let productionCompanies: [Company.Preview]?
        let productionCountries: [Country]?
        let released: Date?
        let revenue: Int?
        let duration: Int?
        let spokenLanguages: [Language]?
        let status: AssetStatus?
        let tagline: String?
        let title: String?
        let averageVote: Float?
        let voteCount: Int?
    }
}
