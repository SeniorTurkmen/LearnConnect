//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import UIKit
import Utilities

public enum ValidateResult {
    case success
    case error(error: String?)
}

public enum TextFieldValidateType {
    case editingChanged
    case editingDidEnd
}

public class ValidableTextField: BaseTextField, ValidatableFields {
    private let validator = Validator()

    public var isValidDidChange: BoolClosure?
    public var textDidChange: OptionalStringClosure?
    public var listenChangeText: OptionalStringClosure?
    public var validateHandler: AnyClosure<ValidateResult>?
    public var isOverridePasteCapability = false
    public var overridePasteClosure: VoidClosure?

    public var isValid = false {
        didSet {
            isValidDidChange?(isValid)
        }
    }

    public override func textFieldDidEndEditing(_ textField: UITextField) {
        if !validator.validations.isEmpty {
            validator.validate(self)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        validate()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        borderStyle = .none
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }

    func addRules(
        rules: [Rule],
        for textFieldValidateType: TextFieldValidateType = .editingDidEnd
    ) {
        removeRules()
        switch textFieldValidateType {
        case .editingChanged:
            addTarget(self, action: #selector(textFieldDidChangeForValidation(_:)), for: .editingChanged)

        case .editingDidEnd:
            addTarget(self, action: #selector(textFieldDidChangeForValidation(_:)), for: .editingDidEnd)
        }
        validator.registerField(self, rules: rules)
    }

    func removeRules() {
        removeTarget(self, action: #selector(textFieldDidChangeForValidation(_:)), for: .editingDidEnd)
        removeTarget(self, action: #selector(textFieldDidChangeForValidation(_:)), for: .editingChanged)
        validator.unregisterField(self)
    }

    @objc func textFieldDidChangeForValidation(_ textField: UITextField) {
        textDidChange?(textField.text)
        listenChangeText?(textField.text)
        validator.validate(self)
    }

    public func validate() {
        if !validator.validations.isEmpty {
            validator.validate(self)
        }
    }

    public override func paste(_ sender: Any?) {
        if isOverridePasteCapability {
            overridePasteClosure?()
        } else {
            let string = UIPasteboard.general.string ?? ""
            let fullString = "\(text ?? "")\(string)"
            if let limit = self.limit, fullString.count > limit {
                return
            }
            text = fullString
            sendActions(for: .editingChanged)
        }
    }
}

// MARK: - ValidationDelegate
extension ValidableTextField: ValidationDelegate {
    public func validationSuccessful() {
        isValid = true
        validateHandler?(.success)
    }

    public func validationFailed(_ errors: [(Validatable?, ValidationError)]) {
        isValid = false
        validateHandler?(.error(error: errors.first?.1.errorMessage))
    }
}
