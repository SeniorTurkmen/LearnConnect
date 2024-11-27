//
//  LoginViewModel.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Utilities
import Managers
import FirebaseAuth

public protocol LoginViewDataSource {
    var email: String? { get set }
    var password: String? { get set }
}

public protocol LoginViewEventSource {
    
}

public protocol LoginViewProtocol: LoginViewDataSource, LoginViewEventSource {
    func viewDidLoad()
    func clickEvent(name: AnalyticsClickName)
    func loginButtonTapped()
    func registerButtonTapped()
}

public final class LoginViewModel: BaseViewModel<LoginRouter>, LoginViewProtocol {
    
    // MARK: - Publics
    public var email: String?
    public var password: String?
    
    public func viewDidLoad() {
        
    }
    
    public func loginButtonTapped() {
        guard let email, let password else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self else { return }
            self.router.pushMainTabBar()
        }
    }
    
    public func registerButtonTapped() {
        router.pushRegister()
    }
}

// MARK: - DataSources
public extension LoginViewModel {
    
}

// MARK: - ConfigureContents
public extension LoginViewModel {
    
}

// MARK: - Requests
public extension LoginViewModel {
    
}

// MARK: - Events
public extension LoginViewModel {
    func clickEvent(name: AnalyticsClickName) {
        baseAnalyticsProvider.clickEvent(name: name)
    }
}
