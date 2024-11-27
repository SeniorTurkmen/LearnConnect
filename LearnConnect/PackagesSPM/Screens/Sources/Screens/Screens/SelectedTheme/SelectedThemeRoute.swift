//
//  SelectedThemeRoute.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//
import DataProvider

public protocol SelectedThemeRoute {
    func presentSelectedTheme()
}

public extension SelectedThemeRoute where Self: RouterProtocol {
    
    func presentSelectedTheme() {
        let router = SelectedThemeRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = SelectedThemeAnalyticsProvider()
        let viewModel = SelectedThemeViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider
        )
        let viewController = SelectedThemeViewController(viewModel: viewModel)
        
        let transition = BottomSheetTransistation()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
