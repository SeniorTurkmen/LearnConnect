//
//  ProfileViewModel.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Utilities
import Managers
import UIComponents

public protocol ProfileViewDataSource {
}

public protocol ProfileViewEventSource {
}

public protocol ProfileViewProtocol: ProfileViewDataSource, ProfileViewEventSource {
    func viewDidLoad()
    func clickEvent(name: AnalyticsClickName)
}

public final class ProfileViewModel: BaseViewModel<ProfileRouter>, ProfileViewProtocol {
    
    public func viewDidLoad() {
        
    }
}

// MARK: - DataSources
public extension ProfileViewModel {
    
}

// MARK: - ConfigureContents
public extension ProfileViewModel {
    
}

// MARK: - Requests
public extension ProfileViewModel {
    
}

// MARK: - Events
public extension ProfileViewModel {
    func clickEvent(name: AnalyticsClickName) {
        baseAnalyticsProvider.clickEvent(name: name)
    }
}
