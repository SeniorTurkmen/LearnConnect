//
//  KDBaseResponse.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public struct KDBaseResponse<T: Decodable> {
    public var processStatus: ProcessStatus?
    public var friendlyMessage: FriendlyMessage?
    public var serverTime: Int?
    public var payload: T?
}

// MARK: - Codable
extension KDBaseResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case processStatus
        case friendlyMessage
        case payload
        case serverTime
    }

    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)

        processStatus = try keyedContainer.decodeIfPresent(ProcessStatus.self, forKey: .processStatus)
        friendlyMessage = try keyedContainer.decodeIfPresent(FriendlyMessage.self, forKey: .friendlyMessage)
        payload = try keyedContainer.decodeIfPresent(T.self, forKey: .payload)
        serverTime = try keyedContainer.decodeIfPresent(Int.self, forKey: .serverTime)
    }
}
