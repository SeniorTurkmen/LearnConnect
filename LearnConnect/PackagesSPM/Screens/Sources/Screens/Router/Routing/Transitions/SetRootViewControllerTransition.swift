//
//  SetRootViewControllerTransition.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public class SetRootViewControllerTransition: NSObject {
    var animator: Animator?
    var isAnimated = true
    var completionHandler: (() -> Void)?

    public weak var viewController: UIViewController?

    init(animator: Animator? = nil, isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
}

// MARK: - Transition
extension SetRootViewControllerTransition: Transition {
    public func open(_ viewController: UIViewController) {
        self.viewController?.navigationController?.delegate = self
        self.viewController?.navigationController?.setViewControllers([viewController], animated: true)
    }

    public func close(_ viewController: UIViewController) {
        viewController.navigationController?.dismiss(animated: isAnimated, completion: completionHandler)
    }
}

// MARK: - UINavigationControllerDelegate
extension SetRootViewControllerTransition: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        completionHandler?()
    }

    public func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        if operation == .push {
            animator.isPresenting = true
            return animator
        } else {
            animator.isPresenting = false
            return animator
        }
    }
}
