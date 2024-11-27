//
//  CornerTypes.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public enum CornerTypes {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    case all

    var cornerMask: CACornerMask {
        switch self {
        case .topLeft: return .layerMinXMinYCorner
        case .topRight: return .layerMaxXMinYCorner
        case .bottomLeft: return .layerMinXMaxYCorner
        case .bottomRight: return .layerMaxXMaxYCorner
        case .all: return [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMaxXMaxYCorner
        ]
        }
    }
}
