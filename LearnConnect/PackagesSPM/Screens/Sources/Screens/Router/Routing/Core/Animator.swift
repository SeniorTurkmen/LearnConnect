//
//  Animator.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
