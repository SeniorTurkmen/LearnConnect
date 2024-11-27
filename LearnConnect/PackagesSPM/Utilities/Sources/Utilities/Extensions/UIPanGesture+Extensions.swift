//
//  UIPanGesture+Extensions.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public extension UIPanGestureRecognizer {
    enum Direction {
        case left
        case right
    }

    var direction: Direction? {
        let velocity = self.velocity(in: view)
        let isHorizontalGesture = abs(velocity.x) > abs(velocity.y)
        guard isHorizontalGesture else { return nil }
        return velocity.x > 0 ? .right : .left
    }
}
