//
//  MainTabBar+Deeplink.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Managers

public struct MainTabBarDeeplinkItem: BaseDeeplinkItem {
    public var path: DeeplinkPath = .mainTabBar
    public var isAuthRequired = false

    public func handle(url: URL) {
    }
}
