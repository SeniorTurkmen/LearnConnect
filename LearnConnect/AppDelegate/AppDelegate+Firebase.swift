//
//  AppDelegate+Firebase.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import FirebaseCore
import FirebaseMessaging
import Managers
import UIKit
import FirebaseAuth

extension AppDelegate {
    func configureFirebase() {
        FirebaseConfiguration.shared.setLoggerLevel(FirebaseLoggerLevel.min)
        #if !CONF_STORE
        var args = ProcessInfo.processInfo.arguments
        args.append("-FIRAnalyticsDebugEnabled")
        args.append("-FIRDebugEnabled")
        ProcessInfo.processInfo.setValue(args, forKey: "arguments")
        #endif

        #if CONF_DEV
        configureFirebase(for: "GoogleService-Info-Dev")
        #elseif CONF_BETA
        configureFirebase(for: "GoogleService-Info-Beta")
        #else
        FirebaseApp.configure()
        #endif

        configureFirebaseMessaging()
    }

    func configureFirebaseMessaging() {
        Messaging.messaging().delegate = self
    }

    func checkIsAppOpenByNotification(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        guard let notification = launchOptions?[.remoteNotification] as? [String: Any],
              let deeplink = notification["deeplink"] as? String,
              let url = URL(string: deeplink) else { return }
        DeepLinkManager.shared.isEnable = false
        DeepLinkManager.shared.handle(url: url)
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        guard let deepLink = userInfo["deeplink"] as? String,
              let url = URL(string: deepLink) else { return }
        DeepLinkManager.shared.handle(url: url)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    }
}

fileprivate extension AppDelegate {
    func configureFirebase(for resource: String) {
        if let file = Bundle.main.path(forResource: resource, ofType: "plist"),
           let options = FirebaseOptions(contentsOfFile: file) {
            FirebaseApp.configure(options: options)
        } else {
            FirebaseApp.configure()
        }
    }
}
