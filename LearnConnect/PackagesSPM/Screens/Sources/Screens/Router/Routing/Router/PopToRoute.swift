//
//  PopToRoute.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol PopToRootRoute {
    func popToRoot(isAnimated: Bool)
}

public extension PopToRootRoute where Self: RouterProtocol {
    func popToRoot(isAnimated: Bool = true) {
        guard let navigationController = viewController?.navigationController else {
            return
        }
        navigationController.popToRootViewController(animated: isAnimated)
    }
}
