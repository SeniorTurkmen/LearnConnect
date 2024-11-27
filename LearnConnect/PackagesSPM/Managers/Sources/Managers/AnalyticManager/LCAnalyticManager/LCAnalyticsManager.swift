//
//  LCAnalyticsManager.swift
//  LCore
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation
import Logger

open class LCAnalyticsManager {
    var providers: [LCAnalyticsProvider]
    private let queue: OperationQueue
    static var shared = LCAnalyticsManager()

    private init() {
        providers = []
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = .background
    }

    public class func add(_ providers: [LCAnalyticsProvider], completion: (() -> Void)? = nil) {
        LCAnalyticsManager.shared.add(providers, completion: completion)
    }

    private func add(_ providers: [LCAnalyticsProvider], completion: (() -> Void)? = nil) {
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.append(contentsOf: providers)
            completion?()
        }
    }

    public class func remove(_ provider: LCAnalyticsProvider, completion: (() -> Void)? = nil) {
        LCAnalyticsManager.shared.remove(provider, completion: completion)
    }

    private func remove(_ provider: LCAnalyticsProvider, completion: (() -> Void)? = nil) {
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.removeAll { $0.identifier == provider.identifier }
            completion?()
        }
    }

    public class func reset(completion: (() -> Void)? = nil) {
        LCAnalyticsManager.shared.reset(completion: completion)
    }

    private func reset(completion: (() -> Void)? = nil) {
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.removeAll()
            completion?()
        }
    }

    open class func track(event: String, parameters: [String: Any]? = nil, completion: (() -> Void)? = nil) {
        LCAnalyticsManager.shared.track(event: event, parameters: parameters, completion: completion)
    }

    private func track(event: String, parameters: [String: Any]? = nil, completion: (() -> Void)? = nil) {
        guard !providers.isEmpty else {
            Logger().debug(message: "Unable to track - no available providers")
            completion?()
            return
        }
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.forEach { provider in
                provider.track(event: event, parameters: parameters)
            }
            completion?()
        }
    }

    open class func setUserProperty(value: String?, forName: String) {
        LCAnalyticsManager.shared.setUserProperty(value: value, forName: forName)
    }

    private func setUserProperty(value: String?, forName: String) {
        guard !providers.isEmpty else {
            Logger().debug(message: "Unable to track - no available providers")
            return
        }
        queue.addOperation { [weak self] in
            guard let `self` = self else { return }
            self.providers.forEach { provider in
                provider.setUserProperty(value: value, forName: forName)
            }
        }
    }
}
