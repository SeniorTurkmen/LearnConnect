//
//  DeepLinkManager+Delegate.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import UIComponents

public protocol DeepLinkManagerDelegate: AnyObject {
    func routeToSplash()
    func routeToMainTabBar()
}
