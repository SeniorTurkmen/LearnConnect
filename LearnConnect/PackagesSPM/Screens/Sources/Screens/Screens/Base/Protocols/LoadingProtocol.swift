//
//  LoadingProtocol.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIComponents
import UIKit

public protocol LoadingProtocol {
    func presentLoading()
    func dismissLoading()
}

public extension LoadingProtocol where Self: UIViewController {
    func presentLoading() {
        view.endEditing(true)
        let window = UIApplication.shared.windows.first
        window?.startBlockingActivityIndicator()
    }

    func dismissLoading() {
        let window = UIApplication.shared.windows.first
        window?.stopBlockingActivityIndicator()
    }
}
