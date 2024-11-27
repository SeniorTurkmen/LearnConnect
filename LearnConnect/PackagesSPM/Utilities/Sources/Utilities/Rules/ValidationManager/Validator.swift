//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import UIKit

public class Validator {
    public var validations = ValidatorDictionary<ValidationRule>()
    public var errors = ValidatorDictionary<ValidationError>()
    private var fields = ValidatorDictionary<Validatable>()
    private var successStyleTransform: ((_ validationRule: ValidationRule) -> Void)?
    private var errorStyleTransform: ((_ validationError: ValidationError) -> Void)?

    public init() {}

    private func validateAllFields() {
        errors = ValidatorDictionary<ValidationError>()
        for (_, rule) in validations {
            if let error = rule.validateField() {
                errors[rule.field] = error
                guard let errorStyleTransform else { return }
                errorStyleTransform(error)
            } else {
                guard let successStyleTransform else { return }
                successStyleTransform(rule)
            }
        }
    }

    public func validateField(
        _ field: ValidatableField,
        callback: AnyClosure<ValidationError?>
    ) {
        guard let fieldRule = validations[field] else {
            callback(nil)
            return
        }

        guard let error = fieldRule.validateField() else {
            callback(nil)
            successStyleTransform?(fieldRule)
            return
        }
        errors[field] = error
        errorStyleTransform?(error)
        callback(error)
    }

    public func styleTransformers(
        success: AnyClosure<ValidationRule>?,
        error: AnyClosure<ValidationError>?
    ) {
        successStyleTransform = success
        errorStyleTransform = error
    }

    public func registerField(
        _ field: ValidatableField,
        errorLabel: UILabel? = nil,
        rules: [Rule]
    ) {
        validations[field] = ValidationRule(field: field, rules: rules, errorLabel: errorLabel)
        fields[field] = field
    }

    public func unregisterField(_ field: ValidatableField) {
        validations.removeValueForKey(field)
        errors.removeValueForKey(field)
    }

    public func validate(_ delegate: ValidationDelegate) {
        validateAllFields()
        guard errors.isEmpty else {
            let errors = errors.map { (fields[$1.field], $1) }
            delegate.validationFailed(errors)
            return
        }
        delegate.validationSuccessful()
    }

    public func validate(
        _ callback: AnyClosure<[(Validatable?, ValidationError)]>
    ) {
        self.validateAllFields()
        let errors = errors.map { (fields[$1.field], $1) }
        callback(errors)
    }
}
