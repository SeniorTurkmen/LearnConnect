//
//  SplashRoute.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import DataProvider

public protocol SplashRoute {
    func pushSplash()
}

public extension SplashRoute where Self: RouterProtocol {
    func pushSplash() {
        let router = SplashRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = SplashAnalyticsProvider()
        let viewModel = SplashViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider
        )
        let viewController = SplashViewController(viewModel: viewModel)
        let baseNav = BaseNavigationController(rootViewController: viewController)

        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition

        open(baseNav, transition: transition)
    }
}
