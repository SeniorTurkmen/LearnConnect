//
//  FriendlyMessage.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public struct FriendlyMessage: Decodable, Error {
    public var title: String?
    public var message: String?
    public var buttonPositive: String?
    public var buttonNeutral: String?
    public var buttonNegative: String?
    public var cancellable: Bool?

    public init(
        title: String? = nil,
        message: String? = nil,
        buttonPositive: String? = nil,
        buttonNeutral: String? = nil,
        buttonNegative: String? = nil,
        cancellable: Bool? = true
    ) {
        self.title = title
        self.message = message
        self.buttonPositive = buttonPositive
        self.buttonNeutral = buttonNeutral
        self.buttonNegative = buttonNegative
        self.cancellable = cancellable
    }
}
