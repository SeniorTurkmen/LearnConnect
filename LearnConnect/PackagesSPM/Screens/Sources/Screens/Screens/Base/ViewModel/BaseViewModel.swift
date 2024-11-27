//
//  BaseViewModel.swift
//  MovieApp
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Alamofire
import DataProvider
import Logger
import Managers
import Utilities

public protocol BaseViewModelDataSource: AnyObject {}

public protocol BaseViewModelEventSource: AnyObject {
    var showLoading: VoidClosure? { get set }
    var hideLoading: VoidClosure? { get set }
    var showTryAgain: VoidClosure? { get set }
    var hideTryAgain: VoidClosure? { get set }
    var showAlert: AnyClosure<AlertEntity>? { get set }
    var hideAlert: VoidClosure? { get set }
    var showToast: AnyClosure<AlertEntity>? { get set }
    var hideToast: VoidClosure? { get set }
    var showEmptyView: VoidClosure? { get set }
    var hideEmptyView: VoidClosure? { get set }
    // MARK: - Pop
    var popViewController: VoidClosure? { get set }
}

public protocol BaseViewModelProtocol: BaseViewModelDataSource, BaseViewModelEventSource {
    func tryAgainButtonTapped()
    func trackScreen(
        with name: String?,
        with className: String
    )
}

open class BaseViewModel<R: Router>: BaseViewModelProtocol {
    // MARK: - TryAgainButton
    public var showLoading: VoidClosure?
    public var hideLoading: VoidClosure?

    // MARK: - EmptyView
    public var showEmptyView: VoidClosure?
    public var hideEmptyView: VoidClosure?

    // MARK: - TryAgainButton
    public var showTryAgain: VoidClosure?
    public var hideTryAgain: VoidClosure?

    // MARK: - Alert
    public var showAlert: AnyClosure<AlertEntity>?
    public var hideAlert: VoidClosure?

    // MARK: - Toast
    public var showToast: AnyClosure<AlertEntity>?
    public var hideToast: VoidClosure?

    // MARK: - Pop
    public var popViewController: VoidClosure?

    public let router: R
    public let dataProvider: DataProviderProtocol

    // MARK: - Privates
    public var baseAnalyticsProvider: BaseAnaltyicsProviderProtocol

    public init(
        router: R,
        dataProvider: DataProviderProtocol,
        baseAnalyticsProvider: BaseAnaltyicsProviderProtocol
    ) {
        self.router = router
        self.dataProvider = dataProvider
        self.baseAnalyticsProvider = baseAnalyticsProvider
    }

    public func tryAgainButtonTapped() {
        let status = NetworkReachabilityManager()?.isReachable ?? false
        if status {
            hideTryAgain?()
        }
    }

    public func trackScreen(
        with name: String?,
        with className: String
    ) {
        baseAnalyticsProvider.trackScreen(with: name, with: className)
    }

    #if DEBUG || DEVELOP
    deinit {
        Logger().debug(message: "deinit \(self)")
    }
    #endif
}
