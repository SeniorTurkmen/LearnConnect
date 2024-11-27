//
//  SelectedThemeViewModel.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Utilities
import Managers
import DataProvider
import UIComponents

public protocol SelectedThemeViewDataSource {
    var numberOfItemsInSection: Int { get }
    
    func cellForItemAt(indexPath: IndexPath) -> ThemeCellProtocol
}

public protocol SelectedThemeViewEventSource {
    var reloadData: VoidClosure? { get set }
}

public protocol SelectedThemeViewProtocol: SelectedThemeViewDataSource, SelectedThemeViewEventSource {
    func viewDidLoad()
    func didSelectItemAt(_ indexPath: IndexPath)
}

public final class SelectedThemeViewModel: BaseViewModel<SelectedThemeRouter>, SelectedThemeViewProtocol {
    
    public var reloadData: VoidClosure?
    
    private var themeViewModel: SelectedThemeViewProtocol?
    private var themeCellItems: [ThemeCellProtocol] = [
        ThemeCellModel(image: .imgIphoneLight, isSelected: true, title: "Light", themeType: .light),
        ThemeCellModel(image: .imgIphoneDark, isSelected: false, title: "Dark", themeType: .dark),
        ThemeCellModel(image: .imgIphoneSystem, isSelected: false, title: "System", themeType: .unspecified)
    ]
    
    public func viewDidLoad() {
        configureThemeCellItems()
    }
    
    public func didSelectItemAt(_ indexPath: IndexPath) {
        let type = themeCellItems[indexPath.row].themeType
        themeCellItems = themeCellItems.map({ item in
            let newItem = item
            if newItem.themeType == type {
                newItem.isSelected = true
            } else {
                newItem.isSelected = false
            }
            return newItem
        })
        ThemeHelper.saveLocalTheme(theme: type)
        ThemeHelper.changeTheme(theme: type)
        reloadData?()
    }
}

// MARK: - DataSources
extension SelectedThemeViewModel {
    
    public var numberOfItemsInSection: Int {
        return themeCellItems.count
    }
    
    public func cellForItemAt(indexPath: IndexPath) -> ThemeCellProtocol {
        return themeCellItems[indexPath.row]
    }
}

// MARK: - ConfigureContents
extension SelectedThemeViewModel {
    
    private func configureThemeCellItems() {
        
        themeCellItems = themeCellItems.map({ item in
            if item.themeType == ThemeHelper.currentTheme() {
                item.isSelected = true
            } else {
                item.isSelected = false
            }
            return item
        })
    }
}

// MARK: - Requests
extension SelectedThemeViewModel {
    
}
