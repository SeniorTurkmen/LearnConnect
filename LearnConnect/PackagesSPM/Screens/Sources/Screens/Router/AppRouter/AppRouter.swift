//
//  AppRouter.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Utilities
import Managers

typealias AppRoutes = SplashRoute

public final class AppRouter: Router, AppRoutes {


    public weak var window: UIWindow?

    public func topViewController() -> UIViewController? {
        UIApplication.topViewController()
    }

    public static let shared = AppRouter()

    public override func open(
        _ viewController: UIViewController,
        transition: Transition
    ) {
        self.viewController = topViewController()
        super.open(viewController, transition: transition)
    }

    public func startApp() {
        AppRouter.shared.pushSplash()
    }
}
