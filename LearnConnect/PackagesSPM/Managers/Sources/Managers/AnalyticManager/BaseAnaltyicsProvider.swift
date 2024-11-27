//
//  BaseAnaltyicsProvider.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Utilities
import Logger

public protocol BaseAnaltyicsProviderProtocol: FirebaseAnalyticsTrackable {
    func trackScreen(with name: String?, with className: String)
    func clickEvent(name: AnalyticsClickName)
}

public extension BaseAnaltyicsProviderProtocol {
    func trackScreen(with name: String?, with className: String) {}
}

public extension BaseAnaltyicsProviderProtocol {
    func clickEvent(name: AnalyticsClickName) {
          track(
              event: .clickEvent,
              parameters: [.clickEvent: name.value]
          )
      }
}

public final class BaseAnaltyicsProvider: BaseAnaltyicsProviderProtocol {
    public func trackScreen(with name: String?, with className: String) {
        if let name {
            track(
                event: .screenView,
                parameters: [
                    .screenName: name,
                    .screenClass: className
                ],
                completion: nil
            )
        } else {
            #if DEBUG
            if name.isNilOrEmpty {
                Logger().debug(message: "Add screen name for \(className)")
            }
            #endif
        }
    }
}
