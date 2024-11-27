//
//  CleanNavigationController.swift
//  MovieApp
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIComponents
import UIKit

class CleanNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        interactivePopGestureRecognizer?.delegate = nil
    }

    private func configureContents() {
        let attributed: [NSAttributedString.Key: Any] = [ .foregroundColor: UIColor.blue]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = .red
        UINavigationBar.appearance().tintColor = .clear
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().isOpaque = true
    }
}
