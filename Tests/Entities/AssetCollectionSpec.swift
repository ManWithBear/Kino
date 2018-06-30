//
//  AssetCollectionSpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble

class AssetCollectionSpec: QuickSpec {
    override func spec() {
        describe("Asset collection") {
            it("able to decode from data") {
                // Act: try to decode asset collection
                guard let collection = try? JSONDecoder().decode(AssetCollection.self, from: AssetCollectionSpec.data) else {
                    fail("Unable to decode asset collection")
                    return
                }

                // Assert: check all properties
                expect(collection.id) == 10
                expect(collection.name) == "Star Wars Collection"
                expect(collection.overview) == "An epic space opera theatrical film series created by George Lucas"
                expect(collection.poster) == "/shDFE0i7josMt9IKXdYpnMFFgNV.jpg"
                expect(collection.backdrop) == "/shDFE0i7josMt9IKXdYpnMFFgNV.jpg"
                expect(collection.assets?.count) == 1
            }
        }
    }

    static var data: Data {
        return json.data(using: .utf8)!
    }
    static let json = """
        {
        "id": 10,
        "name": "Star Wars Collection",
        "overview": "An epic space opera theatrical film series created by George Lucas",
        "poster_path": "/shDFE0i7josMt9IKXdYpnMFFgNV.jpg",
        "backdrop_path": "/shDFE0i7josMt9IKXdYpnMFFgNV.jpg",
        "parts": [{"id": 11}]
        }
        """
}
