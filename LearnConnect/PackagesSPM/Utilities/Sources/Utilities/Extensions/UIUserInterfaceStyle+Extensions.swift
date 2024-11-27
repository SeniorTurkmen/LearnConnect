//
//  UIUserInterfaceStyle+Extensions.swift
//  Utilities
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public extension UIUserInterfaceStyle {
    var stringValue: String {
        switch self {
        case .unspecified:
            return "Unspecified"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        @unknown default:
            return "Unknown"
        }
    }
}
