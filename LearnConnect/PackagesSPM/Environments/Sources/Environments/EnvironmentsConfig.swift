//
//  EnvironmentsConfig.swift
//   
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

// MARK: - EnvironmentsConfig
public struct EnvironmentsConfig: Codable {
    public let services: [LCBaseService]

    enum CodingKeys: String, CodingKey {
        case services
    }

    public init(services: [LCBaseService]) {
        self.services = services
    }
}

public extension EnvironmentsConfig {
    func service(for type: LCBaseServiceType) -> LCBaseService? {
        return services.first { $0.type == type }
    }

    func environment(
        for serviceType: LCBaseServiceType,
        environmentType: LCEnvironmentType
    ) -> Environment? {
        return self.service(for: serviceType)?.environment(for: environmentType)
    }
}

// MARK: - LCBaseService
public struct LCBaseService: Codable {
    public let type: LCBaseServiceType
    public let name: String
    public let environments: [Environment]

    enum CodingKeys: String, CodingKey {
        case type = "id"
        case name
        case environments
    }

    public init(type: LCBaseServiceType, name: String, environments: [Environment]) {
        self.type = type
        self.name = name
        self.environments = environments
    }
}

public extension LCBaseService {
    func environment(for type: LCEnvironmentType) -> Environment? {
        return environments.first { $0.type == type }
    }

    func environment(for currentUrl: String) -> Environment? {
        return environments.first {
            !currentUrl.isEmpty && $0.value == currentUrl
        } ?? environments.first {
            $0.type == .local
        }
    }
}

public enum LCBaseServiceType: String, Codable {
    case kdServices = "learn_base_api"
}

// MARK: - Environment
public struct Environment: Codable {
    public let type: LCEnvironmentType
    public let value: String?
    public let name: String

    enum CodingKeys: String, CodingKey {
        case type = "id"
        case value = "value"
        case name = "name"
    }

    public init(type: LCEnvironmentType, value: String?, name: String) {
        self.type = type
        self.value = value
        self.name = name
    }
}

public enum LCEnvironmentType: String, Codable {
    case local
    case dev
    case test
    case prod
    case preprod
    case other

    public init(from decoder: Decoder) throws {
        let env = try decoder.singleValueContainer().decode(String.self)
        self = LCEnvironmentType(rawValue: env) ?? .other
    }
}
