//
//  CountrySpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble

class CountrySpec: QuickSpec {
    override func spec() {
        describe("Country") {
            it("able to decode from data") {
                // Act: try to decode country
                guard let country = try? JSONDecoder().decode(Country.self, from: CountrySpec.data) else {
                    fail("Unable to decode country")
                    return
                }

                // Assert: check all properties
                expect(country.id) == "US"
                expect(country.name) == "United States of America"
            }
        }
    }

    static var data: Data {
        return json.data(using: .utf8)!
    }
    static let json = """
        {
            "iso_3166_1": "US",
            "name": "United States of America"
        }
        """
}
