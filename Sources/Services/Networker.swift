//
//  Networker.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation
import RxSwift

class Networker {

    enum Error: Swift.Error {
        case deinitialized
        case requestFailure
        case wrongURL
        case invalidJSON
    }

    let apiKey: String
    let session: MaybeURLSession
    let jsonDecoder: JSONDecoder

    init(apiKey: String, session: MaybeURLSession) {
        self.apiKey = apiKey
        self.session = session

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        self.jsonDecoder = decoder
    }

    /// Load data from `url` with GET request
    /// - Returns: Either loaded `data` or `Networker.Error`
    func get(from url: URL) -> Single<Data> {
        let request = URLRequest(url: url)
        return Single.create { [weak self] single in
            guard let me = self else {
                single(.error(Error.deinitialized))
                return Disposables.create()
            }
            let task = me.session.dataTask(with: request) { data, _, error in
                guard let result = data else {
                    print("Request failure: \(String(describing: error))")
                    single(.error(Error.requestFailure))
                    return
                }
                single(.success(result))
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }

    /// Build TheMovieDB api url with provided `path`, query `parameters` and `page`
    /// - Returns: Resulted URL or `nil` if url is not valid
    func url(with path: String, parameters: [String: String] = [:], page: Int? = nil) -> URL? {
        let base = "https://api.themoviedb.org/3"
        let queryParams = parameters.map { URLQueryItem(name: $0, value: $1) }
        let apiKey = URLQueryItem(name: "api_key", value: self.apiKey)
        let pageItem = page.map { [URLQueryItem(name: "page", value: String($0))] } ?? []
        var components = URLComponents(string: base + path)
        components?.queryItems = [apiKey] + queryParams + pageItem
        return components?.url
    }
}

extension Networker: MovieSearchProvider {
    func query(_ query: String, page: Int) -> Single<Page<Movie.Preview>> {
        guard let url = url(with: "/search/movie", parameters: ["query": query], page: page) else {
            return .error(Error.wrongURL)
        }
        return get(from: url)
            .decode(by: jsonDecoder)
    }
}

extension Networker {
    func detailsForMovie(with id: Movie.ID) -> Single<Movie.Detail> {
        guard let url = url(with: "/movie/\(id)") else {
            return .error(Error.wrongURL)
        }
        return get(from: url)
            .decode(by: jsonDecoder)
    }
}

private extension PrimitiveSequence where Trait == SingleTrait, Element == Data {
    func decode<T: Decodable>(by decoder: JSONDecoder) -> Single<T> {
        return map { data -> T in
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                print("Fail to decode \(String(describing: T.self)): \(error)")
                throw Networker.Error.invalidJSON
            }
        }
    }
}
