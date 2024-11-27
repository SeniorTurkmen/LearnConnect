//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public extension UIScrollView {
    func calculateIndex() -> Int {
        let scrollContentOffsetY = contentOffset.y
        let scrollViewHeight = frame.height
        let index = Int((scrollContentOffsetY + scrollViewHeight) / scrollViewHeight)
        return index
    }
}
