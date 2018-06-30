//
//  GenreSpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble

class GenreSpec: QuickSpec {
    override func spec() {
        describe("Genre") {
            it("able to decode from data") {
                // Act: try to decode genre
                guard let genre = try? JSONDecoder().decode(Genre.self, from: GenreSpec.data) else {
                    fail("Unable to decode genre")
                    return
                }

                // Assert: check all properties
                expect(genre.id) == 12
                expect(genre.name) == "Adventure"
            }
        }
    }

    static var data: Data {
        return json.data(using: .utf8)!
    }
    static let json = """
        {
        "id": 12,
        "name": "Adventure"
        }
        """
}
