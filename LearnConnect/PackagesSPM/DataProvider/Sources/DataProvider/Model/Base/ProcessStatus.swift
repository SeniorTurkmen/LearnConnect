//
//  ProcessStatus.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public enum ProcessStatus: String, Codable {
    case undefined = "Undefined"
    case success = "Success"
    case badRequest = "BadRequest"
    case accessDenied = "AccessDenied"
    case notFound = "NotFound"
    case error = "Error"
    case internalServerError = "InternalServerError"
    case userNotFound = "UserNotFound"
    case noUpdate = "NoUpdate"
    case softUpdate = "MinorUpdate"
    case mandatoryUpdate = "MajorUpdate"

    case invalidGrant = "invalidGrant"
    case invalidUserInfo = "invalidUserInfo"
    case sessionExpired = "sessionExpired"
    case timeout = "timeout"

    public init(from decoder: Decoder) throws {
        let code = try decoder.singleValueContainer().decode(String.self)
        self = ProcessStatus(rawValue: code) ?? .undefined
    }
}
