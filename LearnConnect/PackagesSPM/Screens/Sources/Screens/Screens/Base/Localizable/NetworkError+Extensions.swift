//
//  NetworkError+Extensions.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import UIKit
import Resources
import DataProvider

public extension NetworkError {
    var localizedTitle: String? {
        switch self {
        case .noInternetConnection: return L10n.Reachability.title
        default: return L10n.Generic.defaultTitle
        }
    }

    var localizedMessage: String? {
        switch self {
        case .noInternetConnection: return L10n.Reachability.desc
        case .decoding(let error):
        #if GADGET
            return String(describing: error.underlyingError)
        #else
            return L10n.Generic.defaultMessage
        #endif
        default: return L10n.Generic.defaultMessage
        }
    }

    var localizedImage: UIImage {
        switch self {
        case .noInternetConnection: return .actions
        default: return .actions
        }
    }
}
