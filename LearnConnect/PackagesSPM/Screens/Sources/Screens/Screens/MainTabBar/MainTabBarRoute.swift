//
//  MainTabBarRoute.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//
import DataProvider

public protocol MainTabBarRoute {
    func pushMainTabBar()
}

public extension MainTabBarRoute where Self: RouterProtocol {
    func pushMainTabBar() {
        let router = MainTabBarRouter()
        let analyticProvider = MainTabBarAnalyticsProvider()
        let viewModel = MainTabBarViewModel(
            router: router,
            dataProvider: DataProvider.shared.apiDataProvider,
            baseAnalyticsProvider: analyticProvider
        )
        let viewController = MainTabBarViewController(viewModel: viewModel)
        
        let transition = PlaceOnWindowTransition()
        router.viewController = viewController
        router.openTransition = transition

        open(viewController, transition: transition)
    }
}
