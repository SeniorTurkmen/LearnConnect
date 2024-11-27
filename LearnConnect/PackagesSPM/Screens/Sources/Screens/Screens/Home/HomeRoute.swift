//
//  HomeRoute.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//
import DataProvider

public protocol HomeRoute {
    func pushHome()
}

public extension HomeRoute where Self: RouterProtocol {
    
    func pushHome() {
        let router = HomeRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = HomeAnalyticsProvider()
        let viewModel = HomeViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider
        )
        let viewController = HomeViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
