//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public typealias ValidatableField = AnyObject & Validatable

public protocol Validatable {
    var validationText: String { get }
}

extension UITextField: Validatable {
    public var validationText: String { text ?? "" }
}
