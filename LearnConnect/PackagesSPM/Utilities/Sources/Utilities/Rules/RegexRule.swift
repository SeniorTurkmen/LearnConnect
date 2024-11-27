//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

open class RegexRule: Rule {
    private var REGEX: String = "^(?=.*?[A-Z]).{8,}$"
    private var message: String

    public init(
        regex: String,
        message: String = "Invalid Regular Expression"
    ) {
        self.REGEX = regex
        self.message = message
    }

    open func validate(_ value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", REGEX)
        return test.evaluate(with: value)
    }

    open func errorMessage() -> String {
        return message
    }
}
