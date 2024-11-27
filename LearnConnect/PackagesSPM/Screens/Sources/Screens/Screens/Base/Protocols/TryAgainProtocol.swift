//
//  TryAgainProtocol.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Resources
import SwiftEntryKit
import UIComponents
import UIKit
import Utilities

public protocol TryAgainProtocol {
    func presentTryAgain(tryAgainTapped: VoidClosure?)
    func hideTryAgain()
}

public extension TryAgainProtocol {
    func presentTryAgain(tryAgainTapped: VoidClosure?) {
        var attributes = EKAttributes.centerFloat
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        attributes.entryBackground = .color(color: EKColor(.clear))
        attributes.screenBackground = .color(color: .init(.black.withAlphaComponent(0.4)))
        attributes.windowLevel = .alerts
        attributes.displayDuration = .infinity
        attributes.screenInteraction = .absorbTouches
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled

    
        let alertView = EKAlertMessageView(
            with: .init(
                simpleMessage: .init(
                    title: .init(text: "deneme", style: .init(font: .bold(12), color: .black)),
                    description: .init(text: "deneme", style: .init(font: .bold(12), color: .black))
                ),
                imagePosition: .top,
                buttonBarContent: .init(with: [], separatorColor: .black, expandAnimatedly: .random())
            )
        )
        SwiftEntryKit.display(entry: alertView, using: attributes)
    }

    func hideTryAgain() {
        SwiftEntryKit.dismiss()
    }
}
