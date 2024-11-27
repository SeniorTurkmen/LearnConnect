//
//  AppDelegate+Theme.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Managers
import UIKit

extension AppDelegate {
    
    func configureTheme() {
        let currentTheme = ThemeHelper.currentTheme()
        window?.overrideUserInterfaceStyle = currentTheme
    }
}
