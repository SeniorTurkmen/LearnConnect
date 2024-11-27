//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public extension UIPageControl {
    func shrinkDots(
        scaleX: CGFloat = 0.8,
        scaleY: CGFloat = 0.8
    ) {
        for subView in subviews {
            subView.transform = .init(scaleX: scaleX, y: scaleY)
        }
    }
}
