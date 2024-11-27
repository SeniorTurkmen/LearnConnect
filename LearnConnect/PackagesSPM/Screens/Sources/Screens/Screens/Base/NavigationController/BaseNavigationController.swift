//
//  BaseNavigationController.swift
//  MovieApp
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Resources
import UIComponents
import UIKit
import Utilities

public class BaseNavigationController: UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
        interactivePopGestureRecognizer?.isEnabled = false
        additionalSafeAreaInsets.top = 20
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureContents()
    }

    public override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }

    private func configureContents() {
        let attributed: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.medium(18)
        ]
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().isOpaque = true
        UINavigationBar.appearance().titleTextAttributes = attributed
        UINavigationBar.appearance().largeTitleTextAttributes = attributed
    }
}
