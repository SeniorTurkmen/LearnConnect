//
//  PopToBack.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol PopToBackRoute {
    func popToBack(isAnimated: Bool)
}

public extension PopToBackRoute where Self: RouterProtocol {
    func popToBack(isAnimated: Bool = true) {
        guard let navigationController = self.viewController?.navigationController else {
            return
        }
        navigationController.popViewController(animated: isAnimated)
    }
}
