//
//  EmailRule.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

open class EmailRule: RegexRule {
    static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

    public convenience init(
        message: String = ""
    ) {
        self.init(regex: EmailRule.regex, message: message)
    }
}
