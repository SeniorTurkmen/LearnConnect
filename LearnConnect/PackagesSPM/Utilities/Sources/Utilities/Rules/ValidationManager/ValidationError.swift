//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public class ValidationError: NSObject {
    public let field: ValidatableField
    public var errorLabel: UILabel?
    public let errorMessage: String

    public init(
        field: ValidatableField,
        errorLabel: UILabel?,
        error: String
    ) {
        self.field = field
        self.errorLabel = errorLabel
        self.errorMessage = error
    }
}
