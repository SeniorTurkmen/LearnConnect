//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol ValidationDelegate: AnyObject {
    func validationSuccessful()
    func validationFailed(_ errors: [(Validatable?, ValidationError)])
}
