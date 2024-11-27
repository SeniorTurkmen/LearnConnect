//
//  PlaceOnWindow.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public class PlaceOnWindowTransition: Transition {
    public var viewController: UIViewController?

    public func open(_ viewController: UIViewController) {
        guard let window = UIApplication.shared.windows.first else { return }
        if window.rootViewController == viewController {
            window.rootViewController?.dismiss(animated: false)
        } else {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                UIView.performWithoutAnimation {
                    window.rootViewController = viewController
                }
            }, completion: nil)
        }
    }

    public func close(_ viewController: UIViewController) {}

    public init() {}
}
