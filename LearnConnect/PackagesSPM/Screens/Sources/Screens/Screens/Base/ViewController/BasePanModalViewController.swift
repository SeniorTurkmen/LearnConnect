//
//  BasePanModalViewController.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Managers
import Foundation
import PanModal
import Resources
import UIKit

// MARK: - Typealias
public typealias PanModalCompletion = () -> Void

// MARK: - BasePanModalViewController
open class BasePanModalViewController: UIViewController, PanModalPresentable {
    // MARK: - Public Data
    public var dismissCompletion: PanModalCompletion?

    public var isDragIndicatorVisible: Bool {
        get {
            dragIndicator.isHidden
        }
        set {
            dragIndicator.bringSubviewToFront(view)
            dragIndicator.isHidden = !newValue
        }
    }

    // MARK: - UI Variables
    private lazy var dragIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 2
        view.backgroundColor = .red
        return view
    }()


    // MARK: - Lifecycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupViews()
        isDragIndicatorVisible = true
    }

    // MARK: - Setup
    private func setupViews() {
        view.addSubview(dragIndicator)
        dragIndicator.topToSuperview(offset: 12)
        dragIndicator.centerXToSuperview()
        dragIndicator.size(.init(width: 36, height: 4))
    }

    // MARK: - Publics
    public var panScrollable: UIScrollView? {
        nil
    }

    public var topOffset: CGFloat {
        0
    }

    public var shortFormHeight: PanModalHeight {
        .intrinsicHeight
    }

    public var longFormHeight: PanModalHeight {
        .intrinsicHeight
    }

    public var allowsTapToDismiss: Bool = false
    public var allowsDragToDismiss: Bool = false

    public var showDragIndicator: Bool {
        false
    }

    public var panModalBackgroundColor: UIColor {
        .black.withAlphaComponent(0.6)
    }

    public var transitionAnimationOptions: UIView.AnimationOptions {
        [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState]
    }

    public var shouldRoundTopCorners: Bool {
        true
    }

    public var cornerRadius: CGFloat {
        12
    }

    public var springDamping: CGFloat {
        0.8
    }

    public var transitionDuration: Double {
        0.5
    }

    public func panModalWillDismiss() {
        view.endEditing(true)
    }

    public func panModalDidDismiss() {
        dismissCompletion?()
    }
}
