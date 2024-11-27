//
//  BaseViewController.swift
//   
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import DataProvider
import Logger
import Managers
import Resources
import UIComponents
import UIKit
import Utilities

open class BaseViewController<V: BaseViewModelProtocol>: UIViewController, BaseViewControllerProtocol {
    public var viewModel: V
    public var animatedPopController = true
    public var screenBounds = UIScreen.main.bounds

    private let window = UIApplication.shared.windows.first

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        return button
    }()

    open var screenName: String? {
        nil
    }

    public var backButtonIsHidden = false {
        didSet {
            backButton.isHidden = backButtonIsHidden
        }
    }

    public var navBarIsHidden: Bool = false {
        didSet {
            navigationController?.setNavigationBarHidden(navBarIsHidden, animated: false)
        }
    }

    public var barType: NavigationBarType? = .back {
        didSet {
            configureBackButton()
        }
    }

    public init(viewModel: V) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
        subscribeAll { [weak self] in
            guard let self else { return }
            tryAgainButtonTapped()
        }
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.trackScreen(with: screenName, with: "\(Self.self)")
    }

    final private func configureContents() {
        view.backgroundColor = .bgColor
        configureBackButton()
    }

    final func configureBackButton() {
        backButton.setImage(barType?.backButtonImage, for: .normal)
        backButton.setImage(barType?.backButtonImage, for: .highlighted)

        let barItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = barItem
    }

    @objc public func popViewController() {
        if isModal {
            dismiss(animated: animatedPopController)
        } else {
            navigationController?.popViewController(animated: animatedPopController)
        }
    }

    @objc func tryAgainButtonTapped() {
        viewModel.tryAgainButtonTapped()
    }

#if DEBUG || DEVELOP
    deinit {
        Logger().debug(message: "deinit \(self)")
    }
#endif
}
