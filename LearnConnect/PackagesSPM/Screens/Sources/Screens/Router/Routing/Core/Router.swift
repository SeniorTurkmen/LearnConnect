//
//  Router.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public protocol RouterProtocol: AnyObject {
    var viewController: UIViewController? { get }

    func open(_ viewController: UIViewController, transition: Transition)
    func close()
}

open class Router: RouterProtocol {
    public weak var viewController: UIViewController?
    public var openTransition: Transition?

    open func open(_ viewController: UIViewController, transition: Transition) {
        transition.viewController = self.viewController
        transition.open(viewController)
    }

    open func close() {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController)
    }

    public init() {}

    #if DEBUG
    deinit {
        print("deinit \(self)")
    }
    #endif
}
