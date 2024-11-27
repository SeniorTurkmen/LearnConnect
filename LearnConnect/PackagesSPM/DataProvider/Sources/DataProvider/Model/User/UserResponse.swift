//
//  File.swift
//  DataProvider
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public struct UserResponse: Decodable {
    public let userid: String?
    public let courses: [Int]?
}
