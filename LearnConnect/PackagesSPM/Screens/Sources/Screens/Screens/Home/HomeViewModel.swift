//
//  HomeViewModel.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Managers
import TinyConstraints
import Utilities
import Resources
import DataProvider
import UIComponents
import FirebaseAuth
import FirebaseCore

public protocol HomeViewDataSource {
    var numberOfRowsInSection: Int { get }
    var response: [CourseResponse]? { get set }
    
    func cellForRowAt(indexPath: IndexPath) -> CourceCellProtocol?
}

public protocol HomeViewEventSource {
    var reloadData: VoidClosure? { get set }
}

public protocol HomeViewProtocol: HomeViewDataSource, HomeViewEventSource {
    func viewDidLoad()
    func clickEvent(name: AnalyticsClickName)
    func didTappedRegister(_ cellModel: CourceCellProtocol)
    func didSelectRowAt(indexPath: IndexPath)
    func getCoursesId(id: String?)
}

public final class HomeViewModel: BaseViewModel<HomeRouter>, HomeViewProtocol {
    
    // MARK: - Events
    public var reloadData: VoidClosure?
    
    // MARK: - Privates
    private var cellItems: [CourceCellProtocol]?
    
    // MARK: - Publics
    public var response: [CourseResponse]?
    
    public func viewDidLoad() {
        getCoursesId(id: Auth.auth().currentUser?.uid)
    }
    
    public func didTappedRegister(_ cellModel: CourceCellProtocol) {
        guard let id = cellModel.id,
              let entity = CoreDataManager.create(CourseEntity.self) else { return }
        entity.id = Int64(id)
        CoreDataManager.update(entity)
        addCourse()
        configureCellItems()
        reloadData?()
    }
    
    public func didSelectRowAt(indexPath: IndexPath) {
        guard let item = response?[indexPath.row] else { return }
        router.pushCourseDetail(contents: item.contents ?? [])
    }
}

// MARK: - DataSources
extension HomeViewModel {
    public var numberOfRowsInSection: Int {
        return cellItems?.count ?? 0
    }
    
    public func cellForRowAt(indexPath: IndexPath) -> CourceCellProtocol? {
        cellItems?[indexPath.row]
    }
}

// MARK: - ConfigureContents
public extension HomeViewModel {
    final func configureCellItems() {
        guard let response else { return }
        let coreItems = CoreDataManager.fetch(CourseEntity.self)
        let items = response.map { item in
            CourceCellModel(
                name: item.name,
                desc: item.description,
                image: item.thumbnail,
                id: item.id,
                isSaved: coreItems.contains { $0.id == Int64(item.id ?? -1) }
            )
        }
        cellItems = items
    }
    
    final func configureCourseIDS(_ response: [Int]?) {
        guard let response else { return }
        CoreDataManager.removeAll(CourseEntity.self)
        response.forEach { item in
            if let entity = CoreDataManager.create(CourseEntity.self) {
                entity.id = Int64(item)
                CoreDataManager.update(entity)
            }
        }
    }
}

// MARK: - Requests
public extension HomeViewModel {
    
    private func fetchCourses()  {
        let request = HomeRequest()
        dataProvider.request(for: request, result: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.response = response
                configureCellItems()
                reloadData?()
            case .failure(let error):
                let alertEntity = AlertBuilder()
                    .setMessage(error.updatedFriendlyMessage)
                    .setType(error.error)
                    .build()
                showAlert?(alertEntity)
            }
        })
    }
    
    private func addCourse() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        let items = CoreDataManager.fetch(CourseEntity.self)
        let convertItem = items.map { Int($0.id) }
        let request = AddCourseRequest(id: id, ids: convertItem)
        dataProvider.request(for: request, result: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                break
            case .failure(let error):
                let alertEntity = AlertBuilder()
                    .setMessage(error.updatedFriendlyMessage)
                    .setType(error.error)
                    .build()
                //showAlert?(alertEntity)
            }
        })
    }
    
    public func getCoursesId(id: String?) {
        guard let id else { return }
        let request = GetCoursesRequest(id: id)
        dataProvider.request(for: request, result: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                configureCourseIDS(response.first?.courses)
                fetchCourses()
            case .failure(let error):
                print("dasda", error)
                let alertEntity = AlertBuilder()
                    .setMessage(error.updatedFriendlyMessage)
                    .setType(error.error)
                    .build()
            }
        })
    }
}

// MARK: - Events
public extension HomeViewModel {
    func clickEvent(name: AnalyticsClickName) {
        baseAnalyticsProvider.clickEvent(name: name)
    }
}
