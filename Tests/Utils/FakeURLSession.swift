//
//  FakeURLSession.swift
//  KinoTests
//
//  Created by Denis Bogomolov on 01/07/2018.
//  Copyright © 2018 kino. All rights reserved.
//

@testable import Kino
import Foundation

class FakeDataTask: MaybeURLSessionDataTask {

    let onResume: () -> Void

    init(_ callback: @escaping () -> Void = { }) {
        onResume = callback
    }

    // MARK: - Resume
    var resumeCallsCount = 0
    var resumeCalled: Bool {
        return resumeCallsCount > 0
    }
    func resume() {
        resumeCallsCount += 1
        onResume()
    }

    // MARK: - Cancel
    var cancelCallsCount = 0
    var cancelCalled: Bool {
        return cancelCallsCount > 0
    }
    func cancel() {
        cancelCallsCount += 1
    }
}

class FakeURLSession: MaybeURLSession {

    // MARK: - Setup
    var data: Data?
    var response: URLResponse?
    var error: Error?

    /// Completion handler called after `responseAfterSeconds` seconds. If `nil`, never called.
    var responseAfterSeconds: Int?

    // MARK: - Statistic
    var dataTaskCallsCount = 0
    var dataTaskCalled: Bool {
        return dataTaskCallsCount > 0
    }
    var dataTaskCalledWithRequest: URLRequest?

    // MARK: - Helpers
    var lastTask: FakeDataTask!

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> MaybeURLSessionDataTask {
        dataTaskCallsCount += 1
        dataTaskCalledWithRequest = request
        let task = FakeDataTask { [time = responseAfterSeconds, data, response, error] in
            guard let sec = time else { return }
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(sec)) {
                completionHandler(data, response, error)
            }
        }
        lastTask = task
        return task
    }
}
