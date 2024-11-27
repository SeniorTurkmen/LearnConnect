//
//  CourseDetailViewModel.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Utilities
import DataProvider
import UIComponents
import Managers

public protocol CourseDetailViewDataSource {
    var contents: [CourseContents] { get set }
    var numberOfRowsInSection: Int { get }
    
    func cellForRowAt(indexPath: IndexPath) -> CourceCellProtocol?
}

public protocol CourseDetailViewEventSource {
    var reloadData: VoidClosure? { get set }
}

public protocol CourseDetailViewProtocol: CourseDetailViewDataSource, CourseDetailViewEventSource {
    func viewDidLoad()
    func clickEvent(name: AnalyticsClickName)
    func didSelectRowAt(indexPath: IndexPath)
}

public final class CourseDetailViewModel: BaseViewModel<CourseDetailRouter>, CourseDetailViewProtocol {
    
    // MARK: - Events
    public var reloadData: VoidClosure?
    
    // MARK: - Publics
    public var contents: [CourseContents] = []
    
    // MARK: - Privates
    private var cellItems: [CourceCellProtocol]?
    
    public init(
        router: CourseDetailRouter,
        dataProvider: DataProviderProtocol,
        baseAnalyticsProvider: BaseAnaltyicsProviderProtocol,
        contents: [CourseContents]
    ) {
        self.contents = contents
        super.init(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: baseAnalyticsProvider
        )
    }

    public func viewDidLoad() {
        configureCellItems()
    }
    
    public func didSelectRowAt(indexPath: IndexPath) {
        let item = contents[indexPath.row]
        router.presentPreviewCourse(content: item)
    }
}

// MARK: - DataSources
extension CourseDetailViewModel {
    public var numberOfRowsInSection: Int {
        return cellItems?.count ?? 0
    }
    
    public func cellForRowAt(indexPath: IndexPath) -> CourceCellProtocol? {
        cellItems?[indexPath.row]
    }
}

// MARK: - ConfigureContents
public extension CourseDetailViewModel {
    final func configureCellItems() {
        guard !contents.isEmpty else { return }
        let items = contents.map {
            CourceCellModel(
                name: $0.title,
                desc: $0.description,
                image: $0.thumbnail,
                id: $0.id
            )
        }
        cellItems = items
        reloadData?()
    }
}

// MARK: - Requests
public extension CourseDetailViewModel {
    
}

// MARK: - Events
public extension CourseDetailViewModel {
    func clickEvent(name: AnalyticsClickName) {
        baseAnalyticsProvider.clickEvent(name: name)
    }
}
