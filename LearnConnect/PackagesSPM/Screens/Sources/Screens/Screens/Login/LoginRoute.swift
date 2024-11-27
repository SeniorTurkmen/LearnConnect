//
//  LoginRoute.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//
import DataProvider

public protocol LoginRoute {
    func pushLogin()
}

public extension LoginRoute where Self: RouterProtocol {
    
    func pushLogin() {
        let router = LoginRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = LoginAnalyticsProvider()
        let viewModel = LoginViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider
        )
        let viewController = LoginViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
