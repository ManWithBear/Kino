//
//  MoviePreviewSpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 28/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble

class MoviePreviewSpec: QuickSpec {
    override func spec() {
        describe("Movie Preview") {
            it("able to decode from data") {
                // Arrange: Prepare dateFormatter, decoder
                let dateFormatter: DateFormatter = {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    return formatter
                }()
                let decoder: JSONDecoder = {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    return decoder
                }()

                // Act: try to decode movie
                guard let movie = try? decoder.decode(MoviePreview.self, from: MoviePreviewSpec.movieData) else {
                    fail("Unable to decode movie")
                    return
                }

                // Assert: check all properties
                expect(movie.poster) == "/cezWGskPY5x7GaglTTRN4Fugfb8.jpg"
                expect(movie.overview) == "When an unexpected enemy emerges and threatens global safety and security..."
                expect(movie.released) == dateFormatter.date(from: "2012-04-25")!
                expect(movie.id) == 24428
                expect(movie.originalTitle) ==  "The Avengers"
                expect(movie.originalLanguage) == "en"
                expect(movie.title) == "The Avengers"
                expect(movie.backdrop) == "/hbn46fQaRmlpBuUrEiFqv0GDL6Y.jpg"
                expect(movie.popularity) == 7.353212
                expect(movie.voteCount) == 8503
                expect(movie.video) == false
                expect(movie.averageVote) == 7.33
            }
        }
    }

    static var movieData: Data {
        return moviePreviewJSON.data(using: .utf8)!
    }
    static let moviePreviewJSON = """
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
        "video": false,
        "vote_average": 7.33
        }
        """
}
