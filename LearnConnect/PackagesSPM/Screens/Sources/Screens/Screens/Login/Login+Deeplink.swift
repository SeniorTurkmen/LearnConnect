//
//  Login+Deeplink.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Managers
import Foundation

public struct LoginDeeplinkItem: BaseDeeplinkItem {
    public var path: DeeplinkPath = .login
    public var isAuthRequired = false
    
    public func handle(url: URL) {
    
    }
}

