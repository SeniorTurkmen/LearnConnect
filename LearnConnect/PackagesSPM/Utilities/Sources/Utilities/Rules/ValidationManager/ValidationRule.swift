//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public class ValidationRule {
    public var field: ValidatableField
    public var errorLabel: UILabel?
    public var rules: [Rule] = []

    public init(
        field: ValidatableField,
        rules: [Rule],
        errorLabel: UILabel?
    ) {
        self.field = field
        self.errorLabel = errorLabel
        self.rules = rules
    }

    public func validateField() -> ValidationError? {
        let rules = rules.filter {
            !$0.validate(field.validationText)
        }
        let mapRules = rules.map { rule -> ValidationError in
            ValidationError(
                field: field,
                errorLabel: errorLabel,
                error: rule.errorMessage()
            )
        }
        return mapRules.first
    }
}
