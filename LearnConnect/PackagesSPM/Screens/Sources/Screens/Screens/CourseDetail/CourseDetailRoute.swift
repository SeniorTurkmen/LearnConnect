//
//  CourseDetailRoute.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//
import DataProvider

public protocol CourseDetailRoute {
    func pushCourseDetail(contents: [CourseContents])
}

public extension CourseDetailRoute where Self: RouterProtocol {
    
    func pushCourseDetail(contents: [CourseContents]) {
        let router = CourseDetailRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = CourseDetailAnalyticsProvider()
        let viewModel = CourseDetailViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider,
            contents: contents
        )
        let viewController = CourseDetailViewController(viewModel: viewModel)
        
        let transition = PushTransition()
        router.viewController = viewController
        router.openTransition = transition
        
        open(viewController, transition: transition)
    }
}
