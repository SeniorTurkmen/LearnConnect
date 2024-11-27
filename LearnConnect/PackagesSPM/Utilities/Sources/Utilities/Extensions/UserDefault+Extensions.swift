//
//  UserDefault+Extensions.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Logger

public extension UserDefaults {
    subscript(key: String) -> Any? {
        get {
            object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    func save<T: Codable>(
        item: T,
        forKey key: String,
        usingEncoder encoder: JSONEncoder = JSONEncoder()
    ) {
        do {
            let data = try encoder.encode(item)
            set(data, forKey: key)
            synchronize()
        } catch let error {
            Logger().error(message: "Failed to encode with error \(error)")
        }
    }

    func read<T: Codable>(
        _ type: T.Type,
        with key: String,
        usingDecoder decoder: JSONDecoder = JSONDecoder()
    ) -> T? {
        guard let data = object(forKey: key) as? Data else { return nil }
        do {
            return try decoder.decode(type.self, from: data)
        } catch let error {
            Logger().error(message: "Failed to encode with error \(error)")
            return nil
        }
    }
}
