//
//  DeepLinkManager.swift
//   
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Foundation

public final class DeepLinkManager {
    public static let shared = DeepLinkManager()
    public weak var delegate: DeepLinkManagerDelegate?

    public var url: URL?
    public var isEnable = true
    private let deeplinkItems: [DeeplinkItem] = DeepLinkItems.deeplinkItems

    @discardableResult
    public func handle(url: URL) -> Bool {
        guard let deeplinkItem = deeplinkItems.first(where: { $0.compare(path: url.path) })
        else { return false }
        redirect(with: url, deeplinkItem: deeplinkItem)
        return true
    }

    public func isDeeplinkAvailable(url: URL) -> Bool {
        guard deeplinkItems.contains(where: { $0.compare(path: url.path) })
        else { return false }
        return true
    }

    public func hadleURLItem() {
        guard let url,
              let deeplinkItem = deeplinkItems.first(where: { $0.compare(path: url.path) })
        else { return }
        redirect(with: url, deeplinkItem: deeplinkItem)
    }

    public func redirect(
        with url: URL,
        deeplinkItem: DeeplinkItem
    ) {
        guard isEnable else { return }
        if let item = deeplinkItem as?  BaseDeeplinkItem {
            handleDeeplinkItem(with: url, deeplinkItem: item)
        }
    }

    public func handleDeeplinkItem(
        with url: URL,
        deeplinkItem:  BaseDeeplinkItem
    ) {
        if !deeplinkItem.isAuthRequired {
            deeplinkItem.handle(url: url)
            self.url = nil
            return
        }
        AppSwitcher.shared.redirectToApp(deeplinkToRun: deeplinkItem.path)
    }
}
