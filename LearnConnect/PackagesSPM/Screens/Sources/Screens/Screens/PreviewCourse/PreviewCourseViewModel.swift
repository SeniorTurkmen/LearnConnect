//
//  PreviewCourseViewModel.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Utilities
import Managers
import DataProvider

public protocol PreviewCourseViewDataSource {
    var content: CourseContents? { get set }
}

public protocol PreviewCourseViewEventSource {
}

public protocol PreviewCourseViewProtocol: PreviewCourseViewDataSource, PreviewCourseViewEventSource {
    func viewDidLoad()
    func clickEvent(name: AnalyticsClickName)
}

public final class PreviewCourseViewModel: BaseViewModel<PreviewCourseRouter>, PreviewCourseViewProtocol {
    
    // MARK: - Publics
    public var content: CourseContents?
    
    public init(
        router: PreviewCourseRouter,
        dataProvider: DataProviderProtocol,
        baseAnalyticsProvider: BaseAnaltyicsProviderProtocol,
        content: CourseContents?
    ) {
        self.content = content
        super.init(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: baseAnalyticsProvider
        )
    }
    
    public func viewDidLoad() {
        
    }
}

// MARK: - DataSources
public extension PreviewCourseViewModel {
    
}

// MARK: - ConfigureContents
public extension PreviewCourseViewModel {
    
}

// MARK: - Requests
public extension PreviewCourseViewModel {
    
}

// MARK: - Events
public extension PreviewCourseViewModel {
    func clickEvent(name: AnalyticsClickName) {
        baseAnalyticsProvider.clickEvent(name: name)
    }
}
