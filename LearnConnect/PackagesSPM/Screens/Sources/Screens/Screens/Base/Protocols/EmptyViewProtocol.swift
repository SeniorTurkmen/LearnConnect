//
//  EmptyViewProtocol.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import TinyConstraints
import UIComponents
import UIKit

public protocol EmptyViewProtocol {
    func showEmptyView()
    func hideEmptyView()
}

public extension EmptyViewProtocol where Self: UIViewController {
    func showEmptyView() {
        let sourceView = UIApplication.shared.windows.first
        DispatchQueue.main.async {
            let noDataView = UIView()
            sourceView?.addSubview(noDataView)
            noDataView.alpha = 0
            noDataView.edgesToSuperview()
            sourceView?.bringSubviewToFront(noDataView)
            UIView.animate(withDuration: 0.25) {
                noDataView.alpha = 1
            }
        }
    }

    func hideEmptyView() {
        let window = UIApplication.shared.windows.first
        let view = self.view
        DispatchQueue.main.async {
            window?.subviews.filter { $0 is UIView }.forEach { $0.removeFromSuperview() }
            view?.subviews.filter { $0 is UIView }.forEach { $0.removeFromSuperview() }
        }
    }
}
