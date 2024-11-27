//
//  CdnConstantsContent.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

// MARK: - CdnConstantsContent
public struct CdnConstantsContent: Codable, Equatable {
    // MARK: - Parameters
    public let strings: [String: String]?
    public let updatedAt: Int?

    public init(
        strings: [String: String]? = nil,
        updatedAt: Int? = nil
    ) {
        self.strings = strings
        self.updatedAt = updatedAt
    }
}
