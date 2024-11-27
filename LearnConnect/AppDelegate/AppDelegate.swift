//
//  AppDelegate.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Managers
import Screens
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // swiftlint:disable force_cast
    static let shared = UIApplication.shared.delegate as! AppDelegate
    // swiftlint:enable force_cast
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) ->  Bool {
        // MARK: - Firebase
        configureFirebase()
        
        // MARK: - Initialize
        initializaBaseURLChanger()
        initializeGadget()
        CoreDataManager.saveContext()

        // Override point for customization after application launch.
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        self.window?.makeKeyAndVisible()
        AppRouter.shared.window = window
        AppRouter.shared.startApp()

        // MARK: - Flex
        initializeGadget()
       
        checkIsAppOpenByNotification(launchOptions: launchOptions)
        UIApplication.shared.registerPush(self)
        // MARK: - IQKeyboard
        configureIQKeyboard()
        return true
    }
}
