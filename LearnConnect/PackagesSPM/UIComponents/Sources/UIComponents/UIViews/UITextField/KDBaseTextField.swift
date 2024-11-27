//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Resources
import UIKit
import Utilities

public class BaseTextField: UITextField {
    public var nextRespoder: UIResponder?
    public var hasForceCapitalizingFirstLetters: Bool? = false
    public var isTextFieldShouldBeginEditing = true
    public var isBorderVisible: Bool? = true
    public var didChangeEditing: VoidClosure?
    public var limit: Int?
    public var padding: UIEdgeInsets = .zero
}

// MARK: - ConfigureContents
extension BaseTextField {
    final func configureContents() {
        delegate = self
        font = .medium(15)
        borderStyle = .none
    }

    private func updateBorderVisibility() {
        guard let isBorderVisible,
              isBorderVisible else { return }
        layer.borderWidth = isFirstResponder ? 1 : 0
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}

extension BaseTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch returnKeyType {
        case .next:
            nextRespoder?.becomeFirstResponder()

        case .done:
            endEditing(true)

        default:
            break
        }
        return true
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isTextFieldShouldBeginEditing
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        updateBorderVisibility()
        didChangeEditing?()
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        updateBorderVisibility()
        didChangeEditing?()
    }
}
