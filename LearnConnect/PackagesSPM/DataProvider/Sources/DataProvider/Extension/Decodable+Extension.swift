//
//  Decodable+Extension.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public extension Decodable {
    init?(from data: Data, using decoder: JSONDecoder = .init()) {
        guard let parsed = try? decoder.decode(Self.self, from: data) else { return nil }
        self = parsed
    }
}
