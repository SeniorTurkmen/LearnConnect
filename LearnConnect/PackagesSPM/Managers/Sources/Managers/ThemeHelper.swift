//
//  ThemeHelper.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public struct ThemeHelper {
    
    public static func changeTheme(theme: UIUserInterfaceStyle?) {
        UIApplication.shared.windows.forEach { window in
            switch theme {
            case .unspecified:
                window.overrideUserInterfaceStyle = .unspecified
            case .light:
                window.overrideUserInterfaceStyle = .light
            case .dark:
                window.overrideUserInterfaceStyle = .dark
            default:
                window.overrideUserInterfaceStyle = .unspecified
            }
        }
    }
    
    public static func currentTheme() -> UIUserInterfaceStyle {
        let current = CoreDataManager.fetch(UserTheme.self).first
        switch current?.style {
        case "Unspecified":
            return .unspecified
        case "Light":
            return .light
        case "Dark":
            return .dark
         default:
            return UITraitCollection.current.themeMode
        }
    }
    
    public static func saveLocalTheme(theme: UIUserInterfaceStyle?) {
        guard let theme else { return }
        CoreDataManager.removeAll(UserTheme.self)
        if let themes = CoreDataManager.create(UserTheme.self) {
            themes.style = theme.stringValue
            CoreDataManager.update(themes)
        }
    }
}
