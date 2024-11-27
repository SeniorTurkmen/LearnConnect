//
//  MinValueRule.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

open class MinValueRule: Rule {
    private var message: String
    private var minValue: Int = 0
    private var spacesRule = false

    public init(
        minValue: Int,
        message: String,
        spacesRule: Bool = false
    ) {
        self.minValue = minValue
        self.message = message
        self.spacesRule = spacesRule
    }

    open func validate(_ value: String) -> Bool {
        spacesRule
        ? value.split(separator: " ").allSatisfy { $0.count >= minValue }
        : value.trimmed.count >= minValue
    }

    open func errorMessage() -> String {
        return message
    }
}
