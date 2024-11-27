//
//  ThemeCellModel.swift
//  UIComponents
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public protocol ThemeCellDataSource: AnyObject {
    var image: UIImage? { get set }
    var isSelected: Bool? { get set }
    var title: String? { get set }
    var themeType: UIUserInterfaceStyle? { get set }
}

public protocol ThemeCellEventSource: AnyObject {
    
}

public protocol ThemeCellProtocol: ThemeCellDataSource, ThemeCellEventSource {
    
}

public final class ThemeCellModel: ThemeCellProtocol {
    
    public var image: UIImage?
    public var isSelected: Bool?
    public var title: String?
    public var themeType: UIUserInterfaceStyle?
    
    public init(image: UIImage?, isSelected: Bool?, title: String?, themeType: UIUserInterfaceStyle?) {
        self.image = image
        self.isSelected = isSelected
        self.title = title
        self.themeType = themeType
    }
}
