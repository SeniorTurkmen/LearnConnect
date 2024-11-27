//
//  DispatchMainable.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol DispatchMainable { }

public extension DispatchMainable {
    func main(_ function: @escaping VoidClosure) {
        DispatchQueue.main.async(execute: function)
    }
}
