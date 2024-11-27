//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public class CharacterSetRule: Rule {
    private let characterSet: CharacterSet
    private var message: String

    public init(
        characterSet: CharacterSet,
        message: String = "Enter valid alpha"
    ) {
        self.characterSet = characterSet
        self.message = message
    }
    public func validate(_ value: String) -> Bool {
        for uni in value.unicodeScalars {
            guard let uniVal = UnicodeScalar(uni.value), characterSet.contains(uniVal) else {
                return false
            }
        }
        return true
    }

    public func errorMessage() -> String {
        return message
    }
}
