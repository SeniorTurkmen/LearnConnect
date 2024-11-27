//
//  Observer.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public final class Observer<T> {
    public typealias ObserverBlock = (T) -> Void

    weak var observer: AnyObject?
    let block: ObserverBlock
    let queue: DispatchQueue

    init(
        observer: AnyObject,
        queue: DispatchQueue,
        block: @escaping ObserverBlock
    ) {
        self.observer = observer
        self.queue = queue
        self.block = block
    }

    deinit {
        observer = nil
    }
}
