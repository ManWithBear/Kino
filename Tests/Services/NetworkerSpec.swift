//
//  NetworkerSpec.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 01/07/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Quick
import Nimble
import RxSwift
import RxBlocking

class NetworkerSpec: QuickSpec {
    override func spec() {
        describe("Networker") {
            var session: FakeURLSession!
            let apiKey = "here_some_api_key"
            var networker: Networker!
            var bag: DisposeBag!
            beforeEach {
                bag = DisposeBag()
                session = FakeURLSession()
                networker = Networker(apiKey: apiKey, session: session)
            }
            context("get request") {
                let url = URL(string: "https://test.com")!
                it("successfully pass data") {
                    // Arrange: prepare session to anser with data
                    let resultData = "data".data(using: .ascii)!
                    session.data = resultData
                    session.responseAfterSeconds = 0

                    // Act: perform request
                    do {
                        let data = try networker.get(from: url).toBlocking(timeout: 1.0).first()
                        // Assert: response from fake session
                        expect(data) == resultData
                    } catch {
                        fail(String(describing: error))
                    }
                }
                it("pass requestFailure on error") {
                    // Arrange: prepare session to answer with error immidiatly
                    session.responseAfterSeconds = 0

                    // Act: perform request
                    do {
                        _ = try networker.get(from: url).toBlocking(timeout: 1.0).first()
                    } catch {
                        // Assert: networker pass requestFailure error
                        guard case .some(.requestFailure) = (error as? Networker.Error) else {
                            fail("Wrong error")
                            return
                        }
                    }
                }
                it("cancel request on dispose") {
                    // Arrange: perform never finished request
                    networker.get(from: url).subscribe().disposed(by: bag)

                    // Act: dispose request
                    bag = DisposeBag()

                    // Assert: task have been canceled
                    expect(session.lastTask?.cancelCalled) == true
                }
            }
            context("url builder") {
                it("build proper url without page") {
                    // Arrange: prepare components
                    let path = "/path"
                    let param = ["p1": "v1", "p2": "v2"]
                    let resultURL = "https://api.themoviedb.org/3\(path)?api_key=\(apiKey)&p1=v1&p2=v2"

                    // Act: build url
                    let url = networker.url(with: path, parameters: param, page: nil)

                    // Assert: url should be same as result
                    expect(url?.absoluteString) == resultURL
                }
                it("build proper url with page parameter") {
                    // Arrange: prepare components
                    let path = "/path"
                    let param = ["p1": "v1"]
                    let page = 10
                    let resultURL = "https://api.themoviedb.org/3\(path)?api_key=\(apiKey)&p1=v1&page=\(page)"

                    // Act: build url
                    let url = networker.url(with: path, parameters: param, page: page)

                    // Assert: url should be same as result
                    expect(url?.absoluteString) == resultURL
                }
            }
            context("movie search") {
                it("build proper url") {
                    // Arrange: build expected url
                    let resultUrl = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=query&page=20"

                    // Act: perform movie search request
                    networker.query("query", page: 20).subscribe().disposed(by: bag)

                    // Assert: netwroker build proper urk
                    expect(session.dataTaskCalledWithRequest?.url?.absoluteString) == resultUrl
                }
                it("throw invalidJSON on decode error") {
                    // Arrange: prepare session to answer with data immidiatly
                    session.data = "wrong data".data(using: .ascii)!
                    session.responseAfterSeconds = 0

                    // Act: perform request
                    do {
                        _ = try networker.query("q", page: 1).toBlocking(timeout: 1.0).first()
                    } catch {
                        // Assert: networker pass requestFailure error
                        guard case .some(.invalidJSON) = (error as? Networker.Error) else {
                            fail("Wrong error")
                            return
                        }
                    }
                }
                it("properly decode object") {
                    // Arrange: prepare session to answer with data immidiatly
                    let page = Page<Movie.Preview>(page: 1, results: [], totalResults: 120, totalPages: 10)
                    session.data = try! JSONEncoder().encode(page)
                    session.responseAfterSeconds = 0

                    // Act: perform request
                    do {
                        let loadedPage = try networker.query("q", page: 1).toBlocking(timeout: 1.0).first()
                        // Assert: networker properly decode object
                        expect(loadedPage?.page) == page.page
                        expect(loadedPage?.results) == page.results
                        expect(loadedPage?.totalPages) == page.totalPages
                        expect(loadedPage?.totalResults) == page.totalResults
                    } catch {
                        fail(String(describing: error))
                    }
                }
            }
            context("movie details") {
                it("build proper url") {
                    // Arrange: build expected url
                    let resultUrl = "https://api.themoviedb.org/3/movie/210?api_key=\(apiKey)"

                    // Act: perform movie search request
                    networker.detailsForMovie(with: 210).subscribe().disposed(by: bag)

                    // Assert: netwroker build proper urk
                    expect(session.dataTaskCalledWithRequest?.url?.absoluteString) == resultUrl
                }
                it("throw invalidJSON on decode error") {
                    // Arrange: prepare session to answer with data immidiatly
                    session.data = "wrong data".data(using: .ascii)!
                    session.responseAfterSeconds = 0

                    // Act: perform request
                    do {
                        _ = try networker.detailsForMovie(with: 210).toBlocking(timeout: 1.0).first()
                    } catch {
                        // Assert: networker pass requestFailure error
                        guard case .some(.invalidJSON) = (error as? Networker.Error) else {
                            fail("Wrong error")
                            return
                        }
                    }
                }
                it("properly decode object") {
                    // Arrange: prepare session to answer with data immidiatly
                    let detail = Movie.Detail.dummy
                    session.data = try! JSONEncoder().encode(detail)
                    session.responseAfterSeconds = 0

                    // Act: perform request
                    do {
                        let loadedDetail = try networker.detailsForMovie(with: 210).toBlocking(timeout: 1.0).first()
                        // Assert: networker properly decode object
                        expect(loadedDetail) == detail
                    } catch {
                        fail(String(describing: error))
                    }
                }
            }
        }
    }
}
