// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
import RxSwift
@testable import Kino

// MARK: - Flows
// Expected to have struct with name SomeModuleFlow, which contain only non-optional closures as properties
class SearchFlowMock {

    // MARK: - onItemSelection
    var onItemSelectionCallsCount = 0
    var onItemSelectionCalled: Bool {
        return onItemSelectionCallsCount > 0
    }
    /// Will be called inside onItemSelection closure if not nil
    var onItemSelectionRaw: ((Movie.Preview) -> Void)?
    var onItemSelectionReceived: Movie.Preview?

    // MARK: - Flow
    lazy var flow: SearchFlow = SearchFlow(
            onItemSelection: { 
                self.onItemSelectionReceived = $0
                self.onItemSelectionCallsCount += 1
                self.onItemSelectionRaw?($0)
            }
    )
}

// MARK: - AutoMockable protocols
class MovieSearchProviderMock: MovieSearchProvider {

    // MARK: - query

    var queryPageCallsCount = 0
    var queryPageCalled: Bool {
        return queryPageCallsCount > 0
    }
    var queryPageReceivedArguments: (query: String, page: Int)?
    var queryPageReturnValue: Single<Page<Movie.Preview>>!
    var queryPageClosure: ((String, Int) -> Single<Page<Movie.Preview>>)?

    func query(_ query: String, page: Int) -> Single<Page<Movie.Preview>> {
        queryPageCallsCount += 1
        queryPageReceivedArguments = (query: query, page: page)
        return queryPageClosure.map({ $0(query, page) }) ?? queryPageReturnValue
    }

}
class SearchFactoryMock: SearchFactory {

    // MARK: - make

    var makeWithCallsCount = 0
    var makeWithCalled: Bool {
        return makeWithCallsCount > 0
    }
    var makeWithReceivedFlow: SearchFlow?
    var makeWithReturnValue: UIViewController!
    var makeWithClosure: ((SearchFlow) -> UIViewController)?

    func make(with flow: SearchFlow) -> UIViewController {
        makeWithCallsCount += 1
        makeWithReceivedFlow = flow
        return makeWithClosure.map({ $0(flow) }) ?? makeWithReturnValue
    }

}
class SearchViewModelMock: SearchViewModel {
    var searchStateStream: PublishObservable<SearchState> {
        get { return underlyingSearchStateStream }
        set(value) { underlyingSearchStateStream = value }
    }
    var underlyingSearchStateStream: PublishObservable<SearchState>!

    // MARK: - didChangeSearch

    var didChangeSearchCallsCount = 0
    var didChangeSearchCalled: Bool {
        return didChangeSearchCallsCount > 0
    }
    var didChangeSearchReceivedText: String?
    var didChangeSearchClosure: ((String) -> Void)?

    func didChangeSearch(_ text: String) {
        didChangeSearchCallsCount += 1
        didChangeSearchReceivedText = text
        didChangeSearchClosure?(text)
    }

    // MARK: - didCancel

    var didCancelCallsCount = 0
    var didCancelCalled: Bool {
        return didCancelCallsCount > 0
    }
    var didCancelClosure: (() -> Void)?

    func didCancel() {
        didCancelCallsCount += 1
        didCancelClosure?()
    }

    // MARK: - didSelectItem

    var didSelectItemAtCallsCount = 0
    var didSelectItemAtCalled: Bool {
        return didSelectItemAtCallsCount > 0
    }
    var didSelectItemAtReceivedIndex: Int?
    var didSelectItemAtClosure: ((Int) -> Void)?

    func didSelectItem(at index: Int) {
        didSelectItemAtCallsCount += 1
        didSelectItemAtReceivedIndex = index
        didSelectItemAtClosure?(index)
    }

    // MARK: - loadData

    var loadDataCallsCount = 0
    var loadDataCalled: Bool {
        return loadDataCallsCount > 0
    }
    var loadDataClosure: (() -> Void)?

    func loadData() {
        loadDataCallsCount += 1
        loadDataClosure?()
    }

    // MARK: - retryLoading

    var retryLoadingCallsCount = 0
    var retryLoadingCalled: Bool {
        return retryLoadingCallsCount > 0
    }
    var retryLoadingClosure: (() -> Void)?

    func retryLoading() {
        retryLoadingCallsCount += 1
        retryLoadingClosure?()
    }

}
