//
//  MaybeURLSession.swift
//  Kino
//
//  Created by Denis Bogomolov on 30/06/2018.
//  Copyright © 2018 kino. All rights reserved.
//

import Foundation

/// Wrapper around URLSessionDataTask for easier testing
protocol MaybeURLSessionDataTask {
    func cancel()
    func resume()
}

extension URLSessionDataTask: MaybeURLSessionDataTask { }

/// Wrapper around URLSession for easier testing
protocol MaybeURLSession: class {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> MaybeURLSessionDataTask
}

extension URLSession: MaybeURLSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> MaybeURLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}
