//
//  SplashViewModel.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import DataProvider
import Foundation
import Managers
import Resources
import Utilities
import FirebaseAuth

public protocol SplashViewDataSource {}

public protocol SplashViewEventSource {
    var reloadData: VoidClosure? { get set }
}

public protocol SplashViewProtocol: SplashViewDataSource, SplashViewEventSource {
    func viewDidLoad()
    func clickEvent(name: AnalyticsClickName)
}

public final class SplashViewModel: BaseViewModel<SplashRouter>, SplashViewProtocol {
    // MARK: - Events
    public var reloadData: VoidClosure?
    
    public func viewDidLoad() {
        configureRouteLogic()
    }
}

// MARK: - DataSources
public extension SplashViewModel {
}

// MARK: - ConfigureContents
public extension SplashViewModel {
    final func configureRouteLogic() {
        let hasUser = Auth.auth().currentUser != nil
        guard hasUser else {
            router.pushLogin()
            return
        }
        router.pushMainTabBar()
    }
}

// MARK: - Requests
public extension SplashViewModel {
}

// MARK: - Events
public extension SplashViewModel {
    func clickEvent(name: AnalyticsClickName) {
        baseAnalyticsProvider.clickEvent(name: name)
    }
}
