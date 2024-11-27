//
//  LoadingView.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import TinyConstraints

public class LoadingView: UIView {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.tintColor = .white
        indicator.color = .white
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - UILayout
extension LoadingView {
    final func addSubViews() {
        addIndicator()
    }

    final func addIndicator() {
        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }
}

// MARK: - ConfigureContents
extension LoadingView {
    final func configureView() {
        backgroundColor = .black.withAlphaComponent(0.35)
    }
}

public extension UIWindow {
    func startBlockingActivityIndicator() {
        guard !subviews.contains(where: { $0 is LoadingView }) else { return }

        let activityIndicator = LoadingView()
        activityIndicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicator.frame = bounds

        UIView.transition(
            with: self,
            duration: 0.25,
            options: .transitionCrossDissolve) {
                self.addSubview(activityIndicator)
        }
    }

    func stopBlockingActivityIndicator() {
        subviews.filter { $0 is LoadingView }.forEach { $0.removeFromSuperview() }
    }
}
