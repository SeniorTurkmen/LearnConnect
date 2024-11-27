//
//  AppRequiredRule.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

open class AppRequiredRule: Rule {
    private var message: String

    public init(message: String) {
        self.message = message
    }

    open func validate(_ value: String) -> Bool {
        return !value.isEmpty
    }

    open func errorMessage() -> String {
        return message
    }
}
