//
//  Localizable.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public struct LocalizableResponse: Decodable {
    // MARK: - Parameters
    public let strings: [String: String]?
    public let updatedAt: Int?

    // MARK: - CodingKeys
    private enum CodingKeys: String, CodingKey {
        case strings
        case updatedAt
    }

    public var updateCDNConsent: CdnConstantsContent {
        .init(strings: strings, updatedAt: updatedAt)
    }
}
