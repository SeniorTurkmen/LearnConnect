//
//  CGFloat+Extensions.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public extension CGFloat {
    var half: CGFloat {
        self / 2.0
    }

    static var defaultBottomPadding: CGFloat {
        104
    }
}

// MARK: - CalculatedLoading
public extension CGFloat {
    static func loadingHeight(_ isShow: Bool) -> CGFloat {
        isShow ? 80 : .zero
    }
}
