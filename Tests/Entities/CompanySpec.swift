//
//  CompanySpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble

class CompanySpec: QuickSpec {
    override func spec() {
        describe("ProductionCompany") {
            context("Preview") {
                it("able to decode from data") {
                    // Act: try to decode company preview
                    guard let preview = try? JSONDecoder().decode(Company.Preview.self, from: CompanySpec.data) else {
                        fail("Unable to decode company preview")
                        return
                    }

                    // Assert: check all properties
                    expect(preview.id) == 420
                    expect(preview.name) == "Marvel Studios"
                    expect(preview.logo) == "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png"
                    expect(preview.country) == "US"
                }
            }
        }
    }

    static var data: Data {
        return json.data(using: .utf8)!
    }
    static let json = """
        {
            "id": 420,
            "logo_path": "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png",
            "name": "Marvel Studios",
            "origin_country": "US"
        }
        """
}
