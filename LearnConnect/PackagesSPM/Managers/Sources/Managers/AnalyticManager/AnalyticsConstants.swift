//
//  AnalyticsConstants.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public enum AnalyticsEventName: String, Equatable, Hashable {
    case screenView = "screen_view"
    case clickEvent = "click_event"
}

public enum AnalyticsParameter: String, Equatable, Hashable {
    case screenName = "screen_name"
    case screenClass = "screen_class"
    case clickEvent = "click_event"
}

public enum AnalyticsClickName {
    case splash

    public var value: String {
        switch self {
        case .splash: return "Splash"
        }
    }
}
