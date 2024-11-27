//
//  FirebaseAnalyticsProvider.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Firebase
import Logger

public class FirebaseAnalyticsProvider: NSObject, LCAnalyticsProvider {
    public var identifier: String

    // MARK: Init
    public init(indentifier: String = "firebase") {
        Analytics.setAnalyticsCollectionEnabled(true)

        self.identifier = indentifier
        super.init()
    }

    // MARK: Track
    public func track(
        event: String,
        parameters: [String: Any]?
    ) {
        Analytics.logEvent(event, parameters: parameters)
        Logger().debug(
            message: "\n******************************************\n" +
            "🔔 Analytics Event Loging 🔔\nEvent: \(event)\n" +
            "Parameters: \(logParameters(parameters ?? ["": ""])) \n******************************************\n"
        )
    }

    // MARK: Set User Property
    public func setUserProperty(
        value: String?,
        forName: String
    ) {
        Analytics.setUserProperty(nil, forName: forName)
        Analytics.setUserProperty(value, forName: forName)
    }

    public func logParameters(_ parameters: [String: Any], emptyStringLevel: Int = 1) -> String {
        var emptyString = "     "

        for _ in 1...emptyStringLevel {
            emptyString += emptyString
        }

        let string = parameters.reduce(String()) { str, parameter in
            var value: String = ""

            if let dicArrayValue = parameter.1 as? [[String: Any]?] {
                dicArrayValue.forEach { dicValue in
                    value += "\(logParameters(dicValue ?? ["": ""], emptyStringLevel: 2))\n"
                }
            } else if let dicValue = parameter.1 as? [String: Any]? {
                value = "\(logParameters(dicValue ?? ["": ""], emptyStringLevel: 2))"
            } else {
                value = "\(parameter.1)"
            }

            let string = "\(emptyString)\(parameter.0) : \(value)"
            return str + "\n" + string
        }
        let logString = "[\(string)\n]"
        return logString
    }
}
