//
//  PopToViewController.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import UIKit

public protocol PopToViewController {
    func popToViewController<T: UIViewController>(typeClass: T.Type, isAnimated: Bool)
}
public extension PopToViewController where Self: RouterProtocol {
    func popToViewController<T: UIViewController>(typeClass: T.Type, isAnimated: Bool = true) {
        guard let navigationController = self.viewController?.navigationController else {
            return
        }
        if let viewController = navigationController.viewControllers.first(where: { $0 is T }) {
            navigationController.popToViewController(viewController, animated: isAnimated)
        } else {
            navigationController.popToRootViewController(animated: isAnimated)
        }
    }
}
