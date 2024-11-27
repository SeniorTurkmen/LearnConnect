//
//  RegisterViewController.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Managers
import UIComponents
import Utilities
import Resources

public final class RegisterViewController: BaseViewController<RegisterViewModel> {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bold(32)
        label.text = "Sign In"
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primarySubTitleColor
        label.font = .bold(12)
        label.text = "Enter your details below & free sign up"
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.roundCorners(corners: [.topLeft, .topRight], radius: 12)
        view.backgroundColor = .primaryContainerColor
        return view
    }()
    
    private lazy var emailTextField: InputView = {
        let view = InputView()
        view.setTitle = "Your  Email"
        view.setPlaceHolder = "example@example.com"
        view.addRules(
            rules: [
                AppRequiredRule(message: "Email Alanı Boş Bırakılamaz"),
                EmailRule(message: "Lütfen Geçerli Bir Email Giriniz")
            ],
            for: .editingChanged
        )
        return view
    }()
    
    private lazy var passWordTextField: InputView = {
        let view = InputView()
        view.setTitle = "Password"
        view.setPlaceHolder = "*******"
        view.addRules(
            rules: [
                AppRequiredRule(message: "Email Alanı Boş Bırakılamaz"),
                MinValueRule(minValue: 3, message: "Minimum 3 karakter")
            ],
            for: .editingChanged
        )
        return view
    }()
    
    private lazy var registerButton: BaseButton = {
        let button = BaseButton()
        button.roundCorners(corners: [.all], radius: 12)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var validator: FieldsValidator = FieldsValidator()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        subscribeViewModel()
        viewModel.viewDidLoad()
    }
    
    public override var screenName: String? {
        return ScreenNameConstants.register
    }
}

// MARK: - UILayout
extension RegisterViewController {
    
    final func addSubViews() {
        addTitleLabel()
        addSubTitleLabel()
        addContainerView()
        addEmailTextField()
        addPasswordTextField()
        addRegisterButton()
    }
    
    final func addTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.topToSuperview(offset: 36, usingSafeArea: true)
        titleLabel.horizontalToSuperview(insets: .horizontal(24))
    }
    
    final func addSubTitleLabel() {
        view.addSubview(subTitleLabel)
        subTitleLabel.horizontalToSuperview(insets: .horizontal(24))
        subTitleLabel.topToBottom(of: titleLabel, offset: 2)
    }
    
    final func addContainerView() {
        view.addSubview(containerView)
        containerView.topToBottom(of: subTitleLabel, offset: 16)
        containerView.edgesToSuperview(excluding: .top)
    }
    
    final func addEmailTextField() {
        containerView.addSubview(emailTextField)
        emailTextField.topToSuperview(offset: 36)
        emailTextField.horizontalToSuperview(insets: .horizontal(24))
    }
    
    final func addPasswordTextField() {
        containerView.addSubview(passWordTextField)
        passWordTextField.topToBottom(of: emailTextField, offset: 24)
        passWordTextField.horizontalToSuperview(insets: .horizontal(24))
    }
    
    final func addRegisterButton() {
        containerView.addSubview(registerButton)
        registerButton.topToBottom(of: passWordTextField, offset: 24)
        registerButton.horizontalToSuperview(insets: .horizontal(32))
        registerButton.height(52)
    }
}

// MARK: - ConfigureContents
extension RegisterViewController {
    
    final func configureContents() {
        configureViewController()
        addValidators()
    }
    
    final func configureViewController() {
        backButtonIsHidden = true
        navigationItem.title = "Register"
    }
    
    final func addValidators() {
        validator.delegate = self
        validator.register(
            fields: [
                emailTextField.textField,
                passWordTextField.textField
            ]
        )
    }
}

// MARK: SubscribeViewModel
extension RegisterViewController {
    
    final func subscribeViewModel() {
        emailTextField.textField.textDidChange = { [weak self] text in
            guard let self else { return }
            viewModel.email = text
        }
        
        passWordTextField.textField.textDidChange = { [weak self] text in
            guard let self else { return }
            viewModel.password = text
        }
    }
}

// MARK: Actions
extension RegisterViewController {
    
    @objc private func registerButtonTapped() {
        viewModel.registerButtonTapped()
    }
}

// MARK: FieldsValidatorDelegate
extension RegisterViewController: FieldsValidatorDelegate {
    public func validateDidSuccess() {
        registerButton.buttonState = .enable
    }
    
    public func validateDidFailure() {
        registerButton.buttonState = .disable
    }
}
