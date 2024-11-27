//
//  UserDefaults+BaseURLs.swift
//  LCCore
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public extension UserDefaults {
    private enum Keys {
        static let service = LCBaseServiceType.kdServices.rawValue
    }

    var serviceURLValue: String {
        get {
            return string(forKey: Keys.service) ?? ""
        }
        set {
            set(newValue, forKey: Keys.service)
        }
    }
}
