//
//  DeeplinkItem.swift
//   
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol DeeplinkItem {
    var path: DeeplinkPath { get }
    var isAuthRequired: Bool { get }
    var isLoggedIn: Bool { get }

    func compare(path: String) -> Bool
    func handle(url: URL)
}

public extension DeeplinkItem {
    func compare(path: String) -> Bool {
        return self.path.rawValue == path
    }
}
