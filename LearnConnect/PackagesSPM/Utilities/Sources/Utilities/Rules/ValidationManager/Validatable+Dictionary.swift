//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public struct ValidatorDictionary<T>: Sequence {
    private var innerDictionary: [ObjectIdentifier: T] = [:]

    public subscript(key: ValidatableField?) -> T? {
        get {
            guard let key else { return nil }
            return innerDictionary[ObjectIdentifier(key)]
        }
        set {
            guard let key else { return }
            innerDictionary[ObjectIdentifier(key)] = newValue
        }
    }

    public mutating func removeAll() {
        innerDictionary.removeAll()
    }

    public mutating func removeValueForKey(_ key: ValidatableField) {
        innerDictionary.removeValue(forKey: ObjectIdentifier(key))
    }

    public var isEmpty: Bool {
        innerDictionary.isEmpty
    }

    public func makeIterator() -> DictionaryIterator<ObjectIdentifier, T> {
        innerDictionary.makeIterator()
    }
}
