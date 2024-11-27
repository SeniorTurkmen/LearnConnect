//
//  OnlyCharRule.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

open class OnlyCharRule: Rule {
    private var message: String
    private let regexRule = RegexRule(regex: "^[a-zA-ZçÇğĞıİöÖşŞüÜ]*$")
    private let spacesRegexRule = RegexRule(regex: "^[a-zA-ZçÇğĞıİöÖşŞüÜ ]*$")
    private var withSpaces = false

    public init(
        message: String,
        withSpaces: Bool = false
    ) {
        self.message = message
        self.withSpaces = withSpaces
    }

    open func validate(_ value: String) -> Bool {
        let isValid = withSpaces
        ? spacesRegexRule.validate(value)
        : regexRule.validate(value)

        return isValid
    }

    open func errorMessage() -> String {
        return message
    }
}
