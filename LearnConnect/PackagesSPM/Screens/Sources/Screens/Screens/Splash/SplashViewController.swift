//
//  SplashViewController.swift
//  
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Managers
import Resources
import UIComponents
import UIKit

public final class SplashViewController: BaseViewController<SplashViewModel> {
    private lazy var splashBG: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        viewModel.viewDidLoad()
        view.backgroundColor = .black
    }

    public override var screenName: String? {
        ScreenNameConstants.splash
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layer.cornerRadius = containerView.frame.height.half
    }
}

// MARK: - UILayout
private extension SplashViewController {
    final func addSubViews() {
        addBGImageView()
        addTopContainerView()
        addLogoImageView()
    }

    final func addBGImageView() {
        view.addSubview(splashBG)
        splashBG.edgesToSuperview()
    }

    final func addTopContainerView() {
        view.addSubview(containerView)
        containerView.topToSuperview(offset: 18, usingSafeArea: true)
        containerView.horizontalToSuperview(insets: .horizontal(48))
        containerView.height(298)
    }

    final func addLogoImageView() {
        containerView.addSubview(logoImageView)
        logoImageView.centerInSuperview()
        logoImageView.size(.init(width: 155, height: 155))
    }
}
