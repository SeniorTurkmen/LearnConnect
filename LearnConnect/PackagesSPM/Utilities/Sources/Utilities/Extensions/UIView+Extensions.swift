//
//  File.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public extension UIView {
    func slideOutFromBottomWithSpringCurve() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 1,
            options: .curveEaseOut
        ) {
            self.transform = .init(translationX: 0, y: -self.bounds.height)
        }
    }

    func animateWithBounceEffect(
        scaleFactor: CGFloat = 0.4,
        duration: TimeInterval = 1,
        damping: CGFloat = 0.4,
        velocity: CGFloat = 0.3
    ) {
        let originalTransform = transform
        transform = .init(translationX: 0, y: 80)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: damping,
            initialSpringVelocity: velocity,
            options: [.curveEaseOut]
        ) {
            self.transform = originalTransform
        }
    }

    func animatedSlideUP(
        scaleFactor: CGFloat = 0.4,
        duration: TimeInterval = 1,
        damping: CGFloat = 0.4,
        velocity: CGFloat = 0.3
    ) {
        let originalTransform = transform
        transform = .init(translationX: 0, y: -UIScreen.main.bounds.height - 40)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: damping,
            initialSpringVelocity: velocity,
            options: [.curveEaseOut]
        ) {
            self.transform = originalTransform
        }
    }
}

// MARK: - Radius
public extension UIView {
    func roundCorners(
        masksToBounds: Bool = false,
        corners: [CornerTypes],
        radius: CGFloat = 12
    ) {
        layer.masksToBounds = masksToBounds
        layer.maskedCorners = CACornerMask(corners.map { $0.cornerMask })
        layer.cornerRadius = radius
    }
}

// MARK: - Defaults
public extension UIView {
    func defaultBorderAndRadius(
        _ color: UIColor = .clear,
        width: CGFloat = 0
    ) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    func defaultRemoveBorder() {
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
    }
}

// MARK: - Shadow
public extension UIView {
    func addShadow(
        color: UIColor,
        alpha: CGFloat = 1,
        height: CGFloat = 4,
        shadowRadius: CGFloat = 10
    ) {
        layer.shadowColor = color.withAlphaComponent(alpha).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = .init(width: 0, height: height)
    }
}

// MARK: - Animate
public extension UIView {
    func withAnimate(
        duration: TimeInterval,
        _ animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration,
            animations: animations,
            completion: completion
        )
    }
}

// MARK: - Divider
public extension UIView {
    func addToDividerView(
        bgColor: UIColor,
        leadingInset: CGFloat = .zero,
        trailingInset: CGFloat = .zero,
        height: CGFloat = 1
    ) {
        let dividerView = UIView()
        dividerView.backgroundColor = bgColor
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dividerView)
        NSLayoutConstraint.activate([
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingInset),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingInset),
            dividerView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
}
