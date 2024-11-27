//
//  SelectedTheme+Analytic.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Managers

public protocol SelectedThemeAnalyticsProviderProtocol: BaseAnaltyicsProviderProtocol {
    func clickEvent(name: AnalyticsClickName)
}

public final class SelectedThemeAnalyticsProvider: SelectedThemeAnalyticsProviderProtocol {
    public func clickEvent(name: AnalyticsClickName) {
        track(
            event: .clickEvent,
            parameters: [.clickEvent: name.value]
        )
    }
    
    public init() {}
}
