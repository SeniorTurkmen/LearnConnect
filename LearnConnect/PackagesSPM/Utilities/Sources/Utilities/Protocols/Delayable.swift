//
//  Delayable.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol Delayable { }

public extension Delayable {
    func after(
        _ seconds: TimeInterval,
        _ function: @escaping VoidClosure
    ) {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + seconds,
            execute: function
        )
    }
}
