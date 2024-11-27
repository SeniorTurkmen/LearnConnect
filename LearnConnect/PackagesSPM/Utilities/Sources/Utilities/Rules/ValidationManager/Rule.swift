//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol Rule {
    func validate(_ value: String) -> Bool
    func errorMessage() -> String
}
