//
//  NavigationBarProtocol.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Resources
import UIKit

public enum NavigationBarType {
    case back
    case close
}

public protocol NavigationBarProtocol {
    var barType: NavigationBarType? { get set }
}

// MARK: - Colors
public extension NavigationBarType {
    var backButtonImage: UIImage {
        switch self {
        case .back:
            return .icBack.withRenderingMode(.alwaysTemplate)

        case .close:
            return .icBack.withRenderingMode(.alwaysTemplate)
        }
    }
}
