//
//  ValidatableField.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol ValidatableFields: AnyObject {
    var isValidDidChange: BoolClosure? { get set }
    var isValid: Bool { get }
}
