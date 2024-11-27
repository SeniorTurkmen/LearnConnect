//
//  ShareProtocol.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public protocol ShareProtocol {
    func presentShare()
}

public extension ShareProtocol where Self: UIViewController {
    func presentShare() {
        let appName = Bundle.main.appName()
        let newUrl = "\(appName)"
        let shareVC = UIActivityViewController(activityItems: [newUrl], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = view
        shareVC.popoverPresentationController?.sourceRect = view.bounds
        self.present(shareVC, animated: true, completion: nil)
    }
}
