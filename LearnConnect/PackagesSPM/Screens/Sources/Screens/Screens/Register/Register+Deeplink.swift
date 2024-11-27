//
//  Register+Deeplink.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Managers
import Foundation

public struct RegisterDeeplinkItem: BaseDeeplinkItem {
    public var path: DeeplinkPath = .register
    public var isAuthRequired = false
    
    public func handle(url: URL) {
    
    }
}

