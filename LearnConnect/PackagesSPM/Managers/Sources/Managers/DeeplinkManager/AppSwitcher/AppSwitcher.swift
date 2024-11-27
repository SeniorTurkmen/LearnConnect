//
//  AppSwitcher.swift
//   
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public final class AppSwitcher {
    public static let shared = AppSwitcher()

    public func redirectToApp(
        deeplinkToRun: DeeplinkPath? = nil,
        queryParams: [String: Any]? = nil,
        title: String? = nil,
        subtitle: String? = nil
    ) {
        guard let deeplinkToRun, let url = URL(string: deeplinkToRun.rawValue) else { return }
        if let queryParams {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
            guard let url = components?.url else { return }
            DeepLinkManager.shared.handle(url: url)
        } else {
            DeepLinkManager.shared.handle(url: url)
        }
    }
}
