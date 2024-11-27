//
//  AppDelegate+Flex.swift
//  LearnConnect
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Environments
import Foundation
#if GADGET
import Atlantis
import FLEX
#endif

extension AppDelegate {
    #if GADGET
    func prepareGadget() {
        FLEXManager.shared.isNetworkDebuggingEnabled = true
        Atlantis.start()
        addFLEXGestureRecongizer()
        addURLChangerGestureRecongizer()
    }

    private func addFLEXGestureRecongizer() {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        recognizer.direction = .right
        recognizer.numberOfTouchesRequired = 2
        self.window?.addGestureRecognizer(recognizer)
    }

    private func addURLChangerGestureRecongizer() {
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        recognizer.direction = .left
        recognizer.numberOfTouchesRequired = 2
        self.window?.addGestureRecognizer(recognizer)
    }

    @objc private func didSwipe(_ recognizer: UISwipeGestureRecognizer) {
        switch recognizer.direction {
        case .right:
            FLEXManager.shared.showExplorer()

        case .left:
            BaseURLChanger.shared.presentURLChanger()

        default:
            break
        }
    }
    #endif

    func initializeGadget() {
        #if GADGET
        prepareGadget()
        #endif
    }

    func initializaBaseURLChanger() {
        BaseURLChanger.shared.initialize()
    }
}
