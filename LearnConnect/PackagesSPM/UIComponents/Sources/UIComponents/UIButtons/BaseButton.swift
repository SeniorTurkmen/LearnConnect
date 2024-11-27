//
//  File.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Resources
import UIKit
import Utilities

public enum BaseButtonState {
    case enable
    case disable
}

public class BaseButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureContents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public var buttonState: BaseButtonState = .enable {
        didSet {
            configureButtonState()
        }
    }

    public var enableTitleColor: UIColor = .white
    public var disableTitleColor: UIColor = .white
    public var enableBGColor: UIColor = .primaryButtonBG
    public var disableBGColor: UIColor = .bgColor
    public var enableBorderColor: UIColor = .clear
    public var disableBorderColor: UIColor = .clear
    public var cornerRadius: CGFloat?
    public var font: UIFont?

    public func updateButtonColors() {
        configureButtonState()
    }
}

// MARK: - ConfigureContents
extension BaseButton {
    final func configureContents() {
        roundCorners(corners: [.all], radius: cornerRadius ?? 12)
        backgroundColor = enableBGColor
        titleLabel?.font = font ?? .medium(16)
        setTitleColor(enableTitleColor, for: .normal)
        setTitleColor(enableTitleColor, for: .highlighted)
        defaultBorderAndRadius(enableBorderColor, width: 2)
        height(56)
        isEnabled = true
    }

    final func configureDisableState() {
        roundCorners(corners: [.all], radius: cornerRadius ?? 12)
        backgroundColor = disableBGColor
        titleLabel?.font = font ?? .medium(16)
        setTitleColor(disableTitleColor, for: .normal)
        setTitleColor(disableTitleColor, for: .highlighted)
        defaultBorderAndRadius(disableBorderColor, width: 2)
        height(56)
        isEnabled = false
    }

    final func configureButtonState() {
        switch buttonState {
        case .enable:
            configureContents()

        case .disable:
            configureDisableState()
        }
    }
}
