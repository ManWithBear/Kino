//
//  LanguageSpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble

class LanguageSpec: QuickSpec {
    override func spec() {
        describe("Language") {
            it("able to decode from data") {
                // Act: try to decode language
                guard let language = try? JSONDecoder().decode(Language.self, from: LanguageSpec.data) else {
                    fail("Unable to decode language")
                    return
                }

                // Assert: check all properties
                expect(language.id) == "en"
                expect(language.name) == "English"
            }
        }
    }

    static var data: Data {
        return json.data(using: .utf8)!
    }
    static let json = """
        {
            "iso_639_1": "en",
            "name": "English"
        }
        """
}
