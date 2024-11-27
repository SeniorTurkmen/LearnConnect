//
//  AppDelegate+IQKeyboard.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import IQKeyboardManagerSwift

extension AppDelegate {
    func configureIQKeyboard() {
        let iqKeyboardManager = IQKeyboardManager.shared
        iqKeyboardManager.enable = true
        iqKeyboardManager.keyboardDistanceFromTextField = 20.0
        iqKeyboardManager.enableAutoToolbar = false
        iqKeyboardManager.resignOnTouchOutside = true
    }
}
