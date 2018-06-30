//
//  MovieSpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 28/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble

class MovieSpec: QuickSpec {
    override func spec() {
        describe("Movie") {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)

            context("Preview") {
                it("able to decode from data") {
                    // Act: try to decode movie preview
                    guard let preview = try? decoder.decode(Movie.Preview.self, from: MovieSpec.previewData) else {
                        fail("Unable to decode movie preview")
                        return
                    }

                    // Assert: check all properties
                    expect(preview.poster) == "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg"
                    expect(preview.overview) == "When an unexpected enemy emerges and threatens global safety and security..."
                    expect(preview.released) == dateFormatter.date(from: "2012-04-25")!
                    expect(preview.id) == 24428
                    expect(preview.originalTitle) ==  "The Avengers"
                    expect(preview.originalLanguage) == "en"
                    expect(preview.title) == "The Avengers"
                    expect(preview.backdrop) == "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg"
                    expect(preview.popularity) == 7.353212
                    expect(preview.voteCount) == 8503
                    expect(preview.averageVote) == 7.33
                }
            }
            context("Detail") {
                it("able to decode from data") {
                    // Act: try to decode movie detail
                    guard let detail = try? decoder.decode(Movie.Detail.self, from: MovieSpec.detailData) else {
                        fail("Unable to decode movie detail")
                        return
                    }

                    // Assert: check all properties
                    expect(detail.isAdult) == false
                    expect(detail.backdrop) == "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg"
                    expect(detail.collections?.count) == 1
                    expect(detail.budget) == 63000000
                    expect(detail.genres?.count) == 1
                    expect(detail.homepage) == "test.com"
                    expect(detail.id) == 550
                    expect(detail.imdbID) == "tt0137523"
                    expect(detail.originalLanguage) == "en"
                    expect(detail.originalTitle) == "Fight Club"
                    expect(detail.overview) == "A ticking-time-bomb insomniac"
                    expect(detail.popularity) == 0.5
                    expect(detail.poster) == "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg"
                    expect(detail.productionCompanies?.count) == 1
                    expect(detail.productionCountries?.count) == 1
                    expect(detail.released) == dateFormatter.date(from: "1999-10-12")!
                    expect(detail.revenue) == 100853753
                    expect(detail.duration) == 139
                    expect(detail.spokenLanguages?.count) == 1
                    expect(detail.status) == .released
                    expect(detail.tagline) == "How much can you know about yourself if you've never been in a fight?"
                    expect(detail.title) == "Fight Club"
                    expect(detail.averageVote) == 7.8
                    expect(detail.voteCount) == 3439
                }
            }
        }
    }

    static var previewData: Data {
        return previewJson.data(using: .utf8)!
    }
    static var detailData: Data {
        return detailJson.data(using: .utf8)!
    }

    static let previewJson = """
        {
        "poster_path": "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg",
        "adult": false,
        "overview": "When an unexpected enemy emerges and threatens global safety and security...",
        "release_date": "2012-04-25",
        "genre_ids": [
        878,
        28,
        12
        ],
        "id": 24428,
        "original_title": "The Avengers",
        "original_language": "en",
        "title": "The Avengers",
        "backdrop_path": "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg",
        "popularity": 7.353212,
        "vote_count": 8503,
        "vote_average": 7.33
        }
        """
    static let detailJson = """
        {
        "adult": false,
        "backdrop_path": "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
        "belongs_to_collection": [{"id": 18}],
        "budget": 63000000,
        "genres": [{"id": 18,"name": "Drama"}],
        "homepage": "test.com",
        "id": 550,
        "imdb_id": "tt0137523",
        "original_language": "en",
        "original_title": "Fight Club",
        "overview": "A ticking-time-bomb insomniac",
        "popularity": 0.5,
        "poster_path": "/fCayJrkfRaCRCTh8GqN30f8oyQF.jpg",
        "production_companies": [{"id": 508}],
        "production_countries": [{"iso_3166_1": "US"}],
        "release_date": "1999-10-12",
        "revenue": 100853753,
        "runtime": 139,
        "spoken_languages": [{"iso_639_1": "en"}],
        "status": "Released",
        "tagline": "How much can you know about yourself if you've never been in a fight?",
        "title": "Fight Club",
        "video": false,
        "vote_average": 7.8,
        "vote_count": 3439
        }
        """
}
