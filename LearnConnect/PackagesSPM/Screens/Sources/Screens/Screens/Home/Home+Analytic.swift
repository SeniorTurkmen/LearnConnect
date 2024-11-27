//
//  Home+Analytic.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Managers

public protocol HomeAnalyticsProviderProtocol: BaseAnaltyicsProviderProtocol {
    func clickEvent(name: AnalyticsClickName)
}

public final class HomeAnalyticsProvider: HomeAnalyticsProviderProtocol {
    public func clickEvent(name: AnalyticsClickName) {
        track(
            event: .clickEvent,
            parameters: [.clickEvent: name.value]
        )
    }
    
    public init() {}
}
