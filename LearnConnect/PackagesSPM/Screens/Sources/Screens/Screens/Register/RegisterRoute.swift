//
//  RegisterRoute.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import DataProvider

public protocol RegisterRoute {
    func pushRegister()
}

public extension RegisterRoute where Self: RouterProtocol {
    
    func pushRegister() {
        let router = RegisterRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = RegisterAnalyticsProvider()
        let viewModel = RegisterViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider
        )
        let viewController = RegisterViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
