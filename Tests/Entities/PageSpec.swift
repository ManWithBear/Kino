//
//  PageSpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 28/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble

class PageSpec: QuickSpec {
    override func spec() {
        describe("Page") {
            it("able to decode from data") {
                // Act: try to decode page
                guard let page = try? JSONDecoder().decode(Page<Int>.self, from: PageSpec.data) else {
                    fail("Unable to decode page")
                    return
                }

                // Assert: check all properties
                expect(page.page) == 1
                expect(page.results) == [1]
                expect(page.totalResults) == 14
                expect(page.totalPages) == 1
            }
        }
    }

    static var data: Data {
        return json.data(using: .utf8)!
    }
    static let json = """
        {
        "page": 1,
        "results": [1],
        "total_results": 14,
        "total_pages": 1
        }
        """
}
