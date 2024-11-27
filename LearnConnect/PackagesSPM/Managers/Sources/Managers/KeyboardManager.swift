//
//  KeyboardManager.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import UIKit

public protocol KeyboardManagerDelegate: AnyObject {
    func keyboardWillShow(_ keyboardHeight: CGFloat)
    func keyboardWillHide()
}

public extension KeyboardManagerDelegate {
    func keyboardWillShow(_ keyboardHeight: CGFloat) {}
    func keyboardWillHide() {}
}

public final class KeyboardManager {
    public weak var delegate: KeyboardManagerDelegate?

    private let isEnableWillChangeFrameNotification: Bool

    public init(isEnableWillChangeFrameNotification: Bool) {
        self.isEnableWillChangeFrameNotification = isEnableWillChangeFrameNotification
        addObservers()
    }

    deinit {
        removeObservers()
    }

    @objc private func keyboardWillShow(_ notification: Notification?) {
        guard let userInfo = notification?.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeigt = keyboardRectangle.height
        delegate?.keyboardWillShow(keyboardHeigt)
    }

    @objc private func keyboardWillHide(_ notification: Notification?) {
        delegate?.keyboardWillHide()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        if isEnableWillChangeFrameNotification {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillShow(_:)),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil
            )
        }
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}
