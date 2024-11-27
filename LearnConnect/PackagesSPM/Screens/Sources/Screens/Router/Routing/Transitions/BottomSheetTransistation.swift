//
//  BottomSheetTransistation.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

@available(iOS 15.0, *)
public class BottomSheetTransistation: NSObject {
    var animator: Animator?
    var isAnimated = true

    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle
    var sheetController: UISheetPresentationController?

    var completionHandler: (() -> Void)?

    weak public var viewController: UIViewController?

    init(
        animator: Animator? = nil,
        isAnimated: Bool = true,
        modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
        modalPresentationStyle: UIModalPresentationStyle = .pageSheet
    ) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

// MARK: - Transition

@available(iOS 15.0, *)
extension BottomSheetTransistation: Transition {
    public func open(_ viewController: UIViewController) {
        viewController.transitioningDelegate = self
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        sheetController = viewController.presentationController as? UISheetPresentationController
        sheetController?.detents = [.medium()]
        sheetController?.prefersGrabberVisible = true

        self.viewController?.present(viewController, animated: isAnimated, completion: completionHandler)
    }

    public func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: isAnimated, completion: completionHandler)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

@available(iOS 15.0, *)
extension BottomSheetTransistation: UIViewControllerTransitioningDelegate {
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = true
        return animator
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = false
        return animator
    }
}
