//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import TinyConstraints
import UIKit

public protocol KeyboardStickyViewProtocol {
    var keyboardStickyViewContraits: NSLayoutConstraint? { get }
    var keyboardStickyViewSafeAreaConstraits: NSLayoutConstraint? { get }

    func keyboardWillShow(keyboardHeight: CGFloat, constant: CGFloat)
    func keyboardWillHide(constant: CGFloat)
}

public extension KeyboardStickyViewProtocol where Self: UIViewController {
    func keyboardWillShow(keyboardHeight: CGFloat, constant: CGFloat) {
        keyboardStickyViewContraits?.constant = -(keyboardHeight + constant)
        keyboardStickyViewContraits?.priority = .defaultHigh
        keyboardStickyViewSafeAreaConstraits?.priority = .defaultLow
        UIView.animate(withDuration: 0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }

    func keyboardWillHide(constant: CGFloat) {
        keyboardStickyViewContraits?.priority = .defaultLow
        keyboardStickyViewSafeAreaConstraits?.priority = .defaultHigh
        keyboardStickyViewContraits?.constant = -constant
        UIView.animate(withDuration: 0) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
