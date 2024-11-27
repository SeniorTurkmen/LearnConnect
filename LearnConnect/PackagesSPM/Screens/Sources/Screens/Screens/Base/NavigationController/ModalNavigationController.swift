//
//  ModalNavigationController.swift
//  MovieApp
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public class ModalNavigationController: UINavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        interactivePopGestureRecognizer?.delegate = nil
        navigationBar.isHidden = true
    }

    private func configureContents() {
        let attributed: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        let appearance = UINavigationBarAppearance()
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = attributed
        appearance.backButtonAppearance = backButtonAppearance
        appearance.shadowColor = .clear
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = attributed
        appearance.largeTitleTextAttributes = attributed
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().barTintColor = .red
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    open override var childForStatusBarStyle: UIViewController? {
        topViewController
    }

    public override var childForStatusBarHidden: UIViewController? {
        topViewController
    }
}
