//
//  LCAnalyticsProvider.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol LCAnalyticsProvider {
    var identifier: String { get set }
    func track(event: String, parameters: [String: Any]?)
    func setUserProperty(value: String?, forName: String)
}
