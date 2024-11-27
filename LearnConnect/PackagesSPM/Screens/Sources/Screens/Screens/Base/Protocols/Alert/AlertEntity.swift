//
//  AlertEntity.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import DataProvider
import Foundation
import SwiftEntryKit
import UIComponents
import UIKit
import Utilities

protocol AlertEntityBuilder {
    func setIsLottie(_ isLottie: Bool?) -> Self
    func setAlertImage(_ alertImage: UIImage?) -> Self
    func setProductImage(_ productImage: String?) -> Self
    func setMessage(_ message: FriendlyMessage?) -> Self
    func setType(_ type: NetworkError?) -> Self
    func setCloseButtonHandler(_ closeButtonHandler: ClosureWrapper.VoidClosure?) -> Self
    func setPositiveButtonHandler(_ positiveButtonHandler: ClosureWrapper.VoidClosure?) -> Self
    func setNegativeButtonHandler(_ negativeButtonHandler: ClosureWrapper.VoidClosure?) -> Self
    func build() -> AlertEntity
}

public class AlertBuilder: AlertEntityBuilder {
    private var isLottie: Bool?
    private var alertImage: UIImage?
    private var productImage: String?
    private var message: FriendlyMessage?
    private var type: NetworkError?
    private var closeButtonHandler: ClosureWrapper.VoidClosure? = ClosureWrapper.default()
    private var positiveButtonHandler: ClosureWrapper.VoidClosure? = ClosureWrapper.default()
    private var negativeButtonHandler: ClosureWrapper.VoidClosure? = ClosureWrapper.default()

    public init() {}

    public func setIsLottie(_ isLottie: Bool?) -> Self {
        self.isLottie = isLottie
        return self
    }

    public func setAlertImage(_ alertImage: UIImage?) -> Self {
        self.alertImage = alertImage
        return self
    }

    public func setProductImage(_ productImage: String?) -> Self {
        self.productImage = productImage
        return self
    }

    public func setMessage(_ message: FriendlyMessage?) -> Self {
        self.message = message
        return self
    }

    public func setType(_ type: NetworkError?) -> Self {
        self.type = type
        return self
    }

    public func setCloseButtonHandler(_ closeButtonHandler: ClosureWrapper.VoidClosure?) -> Self {
        self.closeButtonHandler = closeButtonHandler
        return self
    }

    public func setPositiveButtonHandler(_ positiveButtonHandler: ClosureWrapper.VoidClosure?) -> Self {
        self.positiveButtonHandler = positiveButtonHandler
        return self
    }

    public func setNegativeButtonHandler(_ negativeButtonHandler: ClosureWrapper.VoidClosure?) -> Self {
        self.negativeButtonHandler = negativeButtonHandler
        return self
    }

    public func build() -> AlertEntity {
        AlertEntity(
            isLottie: isLottie,
            alertImage: alertImage,
            productImage: productImage,
            message: message,
            type: type,
            closeButtonHandler: closeButtonHandler,
            possitiveButtonHandler: positiveButtonHandler,
            negativeButtonHandler: negativeButtonHandler
        )
    }
}

public struct AlertEntity {
    public let alertImage: UIImage?
    public let isLottie: Bool?
    public let productImage: String?
    public let message: FriendlyMessage?
    public let closeButtonHandler: ClosureWrapper.VoidClosure?
    public let possitiveButtonHandler: ClosureWrapper.VoidClosure?
    public let negativeButtonHandler: ClosureWrapper.VoidClosure?
    public let type: NetworkError?

    init(
        isLottie: Bool? = nil,
        alertImage: UIImage? = nil,
        productImage: String? = nil,
        message: FriendlyMessage? = nil,
        type: NetworkError? = nil,
        closeButtonHandler: ClosureWrapper.VoidClosure? = ClosureWrapper.default(),
        possitiveButtonHandler: ClosureWrapper.VoidClosure? = ClosureWrapper.default(),
        negativeButtonHandler: ClosureWrapper.VoidClosure? = ClosureWrapper.default()
    ) {
        self.isLottie = isLottie
        self.alertImage = alertImage
        self.productImage = productImage
        self.message = message
        self.type = type
        self.closeButtonHandler = closeButtonHandler
        self.possitiveButtonHandler = possitiveButtonHandler
        self.negativeButtonHandler = negativeButtonHandler
    }
}

public enum ClosureWrapper {
    public typealias VoidClosure = () -> Void

    public static func `default`() -> VoidClosure {
        {
            SwiftEntryKit.dismiss()
        }
    }
}
