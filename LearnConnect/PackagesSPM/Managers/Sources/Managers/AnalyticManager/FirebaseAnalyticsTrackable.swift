//
//  FirebaseAnalyticsTrackable.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public protocol FirebaseAnalyticsTrackable {
    func track(
        event: AnalyticsEventName,
        parameters: [AnalyticsParameter: Any?]?,
        completion: (() -> Void)?
    )
}

public extension FirebaseAnalyticsTrackable {
    func track(
        event: AnalyticsEventName,
        parameters: [AnalyticsParameter: Any?]? = nil,
        completion: (() -> Void)? = nil
    ) {
        let params = parameters?.compactMapValues { $0 }
        LCAnalyticsManager.track(
            event: event.rawValue,
            parameters: params?.compactMapKeysAndValues {
                ($0.key.rawValue, $0.value)
            },
            completion: completion
        )
    }
}
