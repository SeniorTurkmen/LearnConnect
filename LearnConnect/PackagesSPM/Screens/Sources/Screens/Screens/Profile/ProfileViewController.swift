//
//  ProfileViewController.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Managers
import Utilities
import Resources
import UIComponents
import FirebaseAuth

public final class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .imgProfile
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium(24)
        label.textAlignment = .center
        label.textColor = .primarySubTitleColor
        return label
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.roundCorners(corners: [.all], radius: 12)
        button.setTitle("LogOut", for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var changeThemeButton: UIButton = {
        let button = UIButton()
        button.roundCorners(corners: [.all], radius: 12)
        button.setTitle("Change Theme", for: .normal)
        button.addTarget(self, action: #selector(changeThemeButtonTappped), for: .touchUpInside)
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        viewModel.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override var screenName: String? {
        return ScreenNameConstants.profile
    }
}

// MARK: - UILayout
extension ProfileViewController {
    
    final func addSubViews() {
        addProfileImageView()
        addTitleLabel()
        addLogoutButton()
        addChangeTheme()
    }
    
    final func addProfileImageView() {
        view.addSubview(profileImageView)
        profileImageView.topToSuperview(offset: 24, usingSafeArea: true)
        profileImageView.centerXToSuperview()
        profileImageView.size(.init(width: 64, height: 88))
    }
    
    final func addTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.topToBottom(of: profileImageView, offset: 24)
        titleLabel.horizontalToSuperview(insets: .horizontal(24))
    }
    
    final func addLogoutButton() {
        view.addSubview(logOutButton)
        logOutButton.topToBottom(of: titleLabel, offset: 32)
        logOutButton.horizontalToSuperview(insets: .horizontal(32))
        logOutButton.height(52)
    }
    
    final func addChangeTheme() {
        view.addSubview(changeThemeButton)
        changeThemeButton.topToBottom(of: logOutButton, offset: 16)
        changeThemeButton.horizontalToSuperview(insets: .horizontal(32))
        changeThemeButton.height(52)
    }
}

// MARK: - ConfigureContents
extension ProfileViewController {
    
    final func configureContents() {
        configureViewController()
        configureTitleLabel()
    }
    
    final func configureViewController() {
        navigationItem.title = "Profile"
    }
    
    final func configureTitleLabel() {
        let user = Auth.auth().currentUser
        titleLabel.text = user?.email
    }
}

// MARK: - Actions
extension ProfileViewController {
    
    @objc private func logOutButtonTapped() {
        do {
            try? Auth.auth().signOut()
            viewModel.router.pushSplash()
        } catch {
            
        }
    }
    
    @objc private func changeThemeButtonTappped() {
        viewModel.router.presentSelectedTheme()
    }
}
