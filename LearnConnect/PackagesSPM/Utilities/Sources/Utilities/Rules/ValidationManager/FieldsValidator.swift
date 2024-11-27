//
//  FieldsValidator.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//
import Foundation

public protocol FieldsValidatorDelegate: AnyObject {
    func validateDidSuccess()
    func validateDidFailure()
}

public class FieldsValidator {
    private var fields: [ObjectIdentifier: ValidatableFields] = [:]
    public weak var delegate: FieldsValidatorDelegate?

    // MARK: - Init
    public init() {}

    public func register(field: ValidatableFields) {
        fields[ObjectIdentifier(field)] = field
        field.isValidDidChange = { [weak self] _ in
            guard let self else { return }
            self.validate()
        }
    }

    public func register(fields: [ValidatableFields]) {
        fields.forEach { register(field: $0) }
    }

    public func unregister(field: ValidatableFields) {
        fields.removeValue(forKey: ObjectIdentifier(field))
        field.isValidDidChange = nil
    }

    public func unregister(fields: [ValidatableFields]) {
        fields.forEach { unregister(field: $0) }
    }

    public func unRegisterAll() {
        fields.forEach { unregister(field: $0.value) }
    }

    public func validate() {
        guard fields.contains(where: { !$0.value.isValid }) else {
            delegate?.validateDidSuccess()
            return
        }
        delegate?.validateDidFailure()
    }
}
