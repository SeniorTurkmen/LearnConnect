//
//  RegisterViewModel.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Utilities
import Managers
import FirebaseAuth
import DataProvider

public protocol RegisterViewDataSource {
    var email: String? { get set }
    var password: String? { get set }
}

public protocol RegisterViewEventSource {
}

public protocol RegisterViewProtocol: RegisterViewDataSource, RegisterViewEventSource {
    func viewDidLoad()
    func clickEvent(name: AnalyticsClickName)
    func registerButtonTapped()
}

public final class RegisterViewModel: BaseViewModel<RegisterRouter>, RegisterViewProtocol {
    
    // MARK: - Publics
    public var email: String?
    public var password: String?
    
    public func viewDidLoad() {
        
    }
    
    public func registerButtonTapped() {
        guard let email, let password else { return }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self else { return }
            saveUser()
        }
    }
}

// MARK: - DataSources
public extension RegisterViewModel {
    
}

// MARK: - ConfigureContents
public extension RegisterViewModel {
    
}

// MARK: - Requests
public extension RegisterViewModel {
    
    private func saveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        let request = UserRequest(id: id)
        dataProvider.request(for: request, result: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                self.router.pushMainTabBar()
            case .failure(let error):
                print("dasdas", error)
                self.router.pushMainTabBar()
                let alertEntity = AlertBuilder()
                    .setMessage(error.updatedFriendlyMessage)
                    .setType(error.error)
                    .build()
             //   showAlert?(alertEntity)
            }
        })
    }
}

// MARK: - Events
public extension RegisterViewModel {
    func clickEvent(name: AnalyticsClickName) {
        baseAnalyticsProvider.clickEvent(name: name)
    }
}
