//
//  MainTabBarViewModel.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Managers
import Utilities

public protocol MainTabBarViewDataSource {
}

public protocol MainTabBarViewEventSource {
    var reloadData: VoidClosure? { get set }
}

public protocol MainTabBarViewProtocol: MainTabBarViewDataSource, MainTabBarViewEventSource {
    func viewDidLoad()
    func clickEvent(name: AnalyticsClickName)
}

public final class MainTabBarViewModel: BaseViewModel<MainTabBarRouter>, MainTabBarViewProtocol {
    public var reloadData: VoidClosure?

    public func viewDidLoad() {
    }
}

// MARK: - DataSources
public extension MainTabBarViewModel {
}

// MARK: - ConfigureContents
public extension MainTabBarViewModel {
}

// MARK: - Requests
public extension MainTabBarViewModel {
}

// MARK: - Events
public extension MainTabBarViewModel {
    func clickEvent(name: AnalyticsClickName) {
        baseAnalyticsProvider.clickEvent(name: name)
    }
}
