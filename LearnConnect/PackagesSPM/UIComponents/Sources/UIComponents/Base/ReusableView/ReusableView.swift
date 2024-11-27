//
//  ReusableView.swift
//  UIComponents
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public class ReusableViewModel {
    public init() {
    }
}

public protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
