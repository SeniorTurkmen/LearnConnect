//
//   BaseDeeplinkItem.swift
//   
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol  BaseDeeplinkItem: DeeplinkItem {}

public extension  BaseDeeplinkItem {
    var isLoggedIn: Bool {
        return false
    }
}
