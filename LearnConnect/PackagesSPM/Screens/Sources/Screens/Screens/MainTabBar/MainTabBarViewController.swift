//
//  MainTabBarViewController.swift
//  SnapCrafter
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import DataProvider
import Utilities
import UIComponents
import Resources
import TinyConstraints

final class MainTabBarViewController: UITabBarController {
    private weak var homeNavigationController: BaseNavigationController?
    
    var viewModel: MainTabBarViewProtocol!
    
    private lazy var defaultTabBarHeight = {
        tabBar.frame.size.height
    }()
    
    init(viewModel: MainTabBarViewProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // swiftlint:disable fatal_error unavailable_function
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureViewControllers()
        addObservers()
    }
    
    private func configureTabBar() {
        delegate = self
        tabBar.barTintColor = .blue
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .white
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .black
        tabBarAppearance.stackedLayoutAppearance.normal.badgeBackgroundColor = .red
        tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    override func viewDidLayoutSubviews() {
        var newTabBarFrame = tabBar.frame
        let newTabBarHeight: CGFloat = defaultTabBarHeight + 8
        newTabBarFrame.size.height = newTabBarHeight
        newTabBarFrame.origin.y = self.view.frame.size.height - newTabBarHeight
        tabBar.frame = newTabBarFrame
    }
    
    private func createTabBarItem(unSelectedImage: UIImage, selectedImage: UIImage, title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = unSelectedImage.withRenderingMode(.alwaysTemplate)
        tabBarItem.selectedImage = selectedImage
        tabBar.tintAdjustmentMode = .normal
        tabBarItem.title = title
        tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.red], for: .selected)
        return tabBarItem
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - ConfigureContents
extension MainTabBarViewController {
    
    private func configureContents() {
        configureTabBar()
        configureViewControllers()
    }
    
    private func configureViewControllers() {
        viewControllers = [
            createHomeViewController(),
            createProfileViewController()
        ]
    }
    
    private func popToRoot() {
        if let viewController = selectedViewController as? UINavigationController {
            viewController.popToRootViewController(animated: false)
        } else {
            selectedViewController?.navigationController?.popToRootViewController(animated: false)
        }
    }
}

// MARK: Observers
extension MainTabBarViewController {
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(
                recievedResetIndex
            ),
            name: .resetTabBarIndex,
            object: nil
        )
    }
}

// MARK: - Actions
extension MainTabBarViewController {
    @objc private func recievedResetIndex() {
        guard let homeNavigationController = homeNavigationController,
              let index = viewControllers?.firstIndex(of: homeNavigationController) else { return }
        popToRoot()
        selectedIndex = index
    }
}

// MARK: - UITabBarDelegate
extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
        case homeNavigationController:
            homeNavigationController?.popToRootViewController(animated: true)
        default: break
        }
    }
}

// MARK: Add
extension MainTabBarViewController {
    
    func createHomeViewController() -> UIViewController {
        let router = HomeRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = HomeAnalyticsProvider()
        let viewModel = HomeViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider
        )
        let viewController = HomeViewController(viewModel: viewModel)
        let navigationController = BaseNavigationController(rootViewController: viewController)
        router.viewController = viewController
        homeNavigationController = navigationController
        navigationController.tabBarItem = createTabBarItem(unSelectedImage: .checkmark, selectedImage: .checkmark, title: "Courses")
        return navigationController
    }
    
    func createProfileViewController() -> UIViewController {
        let router = ProfileRouter()
        let dataProvider = DataProvider.shared.apiDataProvider
        let analyticProvider = ProfileAnalyticsProvider()
        let viewModel = ProfileViewModel(
            router: router,
            dataProvider: dataProvider,
            baseAnalyticsProvider: analyticProvider
        )
        let viewController = ProfileViewController(viewModel: viewModel)
        let navigationController = BaseNavigationController(rootViewController: viewController)
        router.viewController = viewController
        homeNavigationController = navigationController
        navigationController.tabBarItem = createTabBarItem(unSelectedImage: .checkmark, selectedImage: .checkmark, title: "Profile")
        return navigationController
    }
}
