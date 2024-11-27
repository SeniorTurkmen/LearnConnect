//
//  CourseResponse.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public struct CourseResponse: Decodable {
    public var name: String?
    public var description: String?
    public var thumbnail: String?
    public var id: Int?
    public var contents: [CourseContents]?
}

public struct CourseContents: Decodable, Equatable {
    public let videURL: String?
    public let id: Int?
    public let type: String?
    public let title: String?
    public let description: String?
    public let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case videURL = "video_url"
        case id
        case type
        case title
        case description
        case thumbnail
    }
    
    public static func == (lhs: CourseContents, rhs: CourseContents) -> Bool {
        return lhs.videURL == rhs.videURL &&
               lhs.id == rhs.id &&
               lhs.type == rhs.type &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.thumbnail == rhs.thumbnail
    }
}
