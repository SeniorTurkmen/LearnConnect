//
//  BaseViewController+Protocol.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import DataProvider
import Resources
import UIKit
import Utilities

typealias BaseProtocols =
LoadingProtocol &
TryAgainProtocol &
EmptyViewProtocol &
AlertProtocol &
NavigationBarProtocol

protocol BaseViewControllerProtocol: UIViewController, BaseProtocols {
    // swiftlint:disable type_name
    associatedtype V: BaseViewModelProtocol
    // swiftlint:enable type_name
    var viewModel: V { get }

    func subscribeAll(tryAgainTapped: VoidClosure?)
    func subscribeTryAgain(tryAgainTapped: VoidClosure?)
    func subscribeLoading()
    func subscribeEmptyView()
    func subscribeAlertView()
}

// MARK: - Subscribe
extension BaseViewControllerProtocol {
    func subscribeAll(tryAgainTapped: VoidClosure?) {
        subscribeTryAgain(tryAgainTapped: tryAgainTapped)
        subscribeLoading()
        subscribeEmptyView()
        subscribeAlertView()
    }
}

// MARK: - EmptyViewPresentProtocol
extension BaseViewControllerProtocol {
    func subscribeEmptyView() {
        viewModel.showEmptyView = { [weak self] in
            guard let self = self else { return }
            self.showEmptyView()
        }

        viewModel.hideEmptyView = { [weak self] in
            guard let self = self else { return }
             self.hideEmptyView()
        }
    }
}

// MARK: - TryAgainButton
extension BaseViewControllerProtocol {
    func subscribeTryAgain(tryAgainTapped: VoidClosure?) {
        viewModel.showTryAgain = { [weak self] in
            guard let self = self else { return }
            self.presentTryAgain(tryAgainTapped: tryAgainTapped)
        }

        viewModel.hideTryAgain = { [weak self] in
            guard let self = self else { return }
             self.hideTryAgain()
        }
    }
}

// MARK: - Loading
extension BaseViewControllerProtocol {
    func subscribeLoading() {
        viewModel.showLoading = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.presentLoading()
            }
        }
        viewModel.hideLoading = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.dismissLoading()
            }
        }
    }
}

// MARK: - Alert
extension BaseViewControllerProtocol {
    func subscribeAlertView() {
        viewModel.showAlert = { [weak self] entity in
            guard let self else { return }
            DispatchQueue.main.async {
                self.configureShowAlert(entity: entity)
            }
        }

        viewModel.hideAlert = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.dismissAlert()
            }
        }
    }
}

// MARK: - ConfigureAlerts
extension BaseViewControllerProtocol {
    func configureShowAlert(entity: AlertEntity) {
        if let message = entity.message {
            self.presentAlert(entity: entity)
        } else if let type = entity.type {
            switch type {
            case .noInternetConnection:
                viewModel.showTryAgain?()

            default:
                let connError = FriendlyMessage(
                    title: type.localizedTitle,
                    message: type.localizedMessage,
                    buttonPositive: L10n.Generic.defaultPositiveButton
                )
                self.presentAlert(entity: entity)
            }
        }
    }
}
