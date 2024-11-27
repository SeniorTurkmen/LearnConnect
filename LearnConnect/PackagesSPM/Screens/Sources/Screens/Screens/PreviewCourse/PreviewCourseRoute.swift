//
//  PreviewCourseRoute.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//
import DataProvider

public protocol PreviewCourseRoute {
    func presentPreviewCourse(content: CourseContents?)
}

public extension PreviewCourseRoute where Self: RouterProtocol {
    
    func presentPreviewCourse(content: CourseContents?) {
        let router = PreviewCourseRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = PreviewCourseAnalyticsProvider()
        let viewModel = PreviewCourseViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider,
            content: content
        )
        let viewController = PreviewCourseViewController(viewModel: viewModel)
        let nav = BaseNavigationController(rootViewController: viewController)
        
        let transition = ModalTransition()
        router.viewController = nav
        router.openTransition = transition
        
        open(nav, transition: transition)
    }
}
