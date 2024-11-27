//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public enum PhoneNumberRuleMaskTypes: String {
    case withCodeExtend = "+XX XXX XXX XX XX"
    case withParent = "(XXX) XXX XX XX"
}

public class PhoneNumberRule: Rule {
    private var message: String = ""

    private let regexRule = RegexRule(
        regex: "^[5][0-9]{9}$"
    )
    private let removeFirstCharacterWhenZero: Bool
    private let validateAreaCodes: Bool

    // Türkiye'de aktif olan cep telefonu alan kodları
    private let validAreaCodes = [
        "501",
        "505",
        "506",
        "507",
        "551",
        "552",
        "553",
        "554",
        "555",
        "559",
        "516",
        "530",
        "531",
        "532",
        "533",
        "534",
        "535",
        "536",
        "537",
        "538",
        "539",
        "561",
        "541",
        "542",
        "543",
        "544",
        "545",
        "546",
        "547",
        "548",
        "549"
    ]

    public init(
        removeFirstCharacterWhenZero: Bool = false,
        validateAreaCodes: Bool = false,
        message: String = ""
    ) {
        self.removeFirstCharacterWhenZero = removeFirstCharacterWhenZero
        self.validateAreaCodes = validateAreaCodes
        self.message = message
    }

    public func validate(_ value: String) -> Bool {
        var value = value.digits
        if removeFirstCharacterWhenZero, value.first == "0" {
            value.removeFirst()
        }
        if validateAreaCodes, !validateBasedOnAreaCodes(value) {
            return false
        }
        guard regexRule.validate(value) else {
            return false
        }
        return true
    }

    public func validateBasedOnAreaCodes(_ value: String) -> Bool {
        for item in 0..<validAreaCodes.count {
            let range = NSString(string: value).range(of: validAreaCodes[item])
            if range.location == 0 {
                return true
            }
        }
        return false
    }

    public func errorMessage() -> String {
        return message
    }

    public func formatGSM(
        _ number: String,
        mask: PhoneNumberRuleMaskTypes = .withParent
    ) -> String {
        let numbers = number.replacingOccurrences(
            of: "[^0-9]",
            with: "",
            options: .regularExpression
        )
        var result = ""
        var index = numbers.startIndex
        for char in mask.rawValue where index < numbers.endIndex {
            if char == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(char)
            }
        }
        return result
    }
}
