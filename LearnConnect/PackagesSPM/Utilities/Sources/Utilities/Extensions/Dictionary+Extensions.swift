//
//  Dictionary+Extensions.swift
//  Utilities
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public extension Dictionary {
    func compactMapKeysAndValues<K, V>(_ transform: ((key: Key, value: Value)) throws -> (K, V)?) rethrows -> [K: V] {
        return [K: V](uniqueKeysWithValues: try compactMap(transform))
    }
}
