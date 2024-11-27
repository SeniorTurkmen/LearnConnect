//
//  InputView.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import Resources
import TinyConstraints
import UIKit
import Utilities

public class InputView: UIView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryInputTitle
        label.font = .medium(14)
        label.numberOfLines = 1
        return label
    }()

    private lazy var errorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .errorDefault700
        label.font = .medium(12)
        label.isHidden = true
        label.numberOfLines = 2
        return label
    }()

    public lazy var textField: ValidableTextField = {
        let textField = ValidableTextField()
        textField.autocorrectionType = .no
        textField.isBorderVisible = false
        textField.keyboardType = .default
        textField.isSecureTextEntry = false
        textField.returnKeyType = .done
        textField.spellCheckingType = .no
        textField.tintColor = .white
        textField.delegate = self
        textField.isOverridePasteCapability = false
        textField.font = .book(14)
        textField.sizeToFit()
        textField.backgroundColor = .primaryInputBGColor
        textField.layer.borderWidth = 1
        textField.textColor = .primaryInputTitle
        textField.layer.borderColor = UIColor.primaryInputTitle.cgColor
        textField.padding = .init(top: 0, left: 20, bottom: 0, right: 0)
        textField.layer.cornerRadius = 12
        return textField
    }()

    private lazy var tappedGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(textFieldTapped))
        return gesture
    }()

    public var validateOnFocusLost: Bool = false
    private var didLoseFocusOnce: Bool = false

    public init(isEditable: Bool = true) {
        self.isEditable = isEditable
        super.init(frame: .zero)
        addSubViews()
        configureView()
        configureContentView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private var heightConstrait: Constraint?
    private var successBorderColor: CGColor = UIColor.green.cgColor
    private var failureBorderColor: CGColor = UIColor.errorDefault700.cgColor
    private var isUpdatesBorderColor = true
    private var isEditable: Bool = true
    private lazy var validator = Validator()
    public var limit: Int?

    public var enablePasteboard = false
    public var didBeginEditing: OptionalStringClosure?

    public var setTitle: String? {
        didSet {
            titleLabel.text = setTitle
        }
    }

    public var setTitleOpacity: Float = .zero {
        didSet {
            titleLabel.layer.opacity = setTitleOpacity
        }
    }

    public var setPlaceHolder: String = "" {
        didSet {
            placeHolderAttributed.text(setPlaceHolder)
            textField.attributedPlaceholder = placeHolderAttributed.attributedString
        }
    }

    private lazy var placeHolderAttributed: AttributedStringBuilder = {
        let attributes = AttributedStringBuilder()
        attributes.defaultAttributes = [
            .textColor(.primaryInputTitle),
            .font(.book(14))
        ]
        return attributes
    }()

    public func addRules(
        rules: [Rule],
        for textFieldValidateType: TextFieldValidateType = .editingDidEnd
    ) {
        textField.addRules(rules: rules, for: textFieldValidateType)
    }

    public var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
}

// MARK: - UILayout
extension InputView {
    final func addSubViews() {
        addTitleLabel()
        addStackView()
    }

    final func addTitleLabel() {
        addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: .bottom)
    }

    final func addStackView() {
        addSubview(errorStackView)
        errorStackView.topToBottom(of: titleLabel, offset: 8)
        errorStackView.edgesToSuperview(excluding: [.top, .bottom])
        errorStackView.bottomToSuperview(relation: .equalOrLess)
        errorStackView.addArrangedSubview(textField)
        errorStackView.addArrangedSubview(errorLabel)
        textField.height(50)
    }
}

// MARK: - ConfigureContents
extension InputView {
    final func configureContentView() {
        configureTextField()
    }

    final func configureView() {
        heightConstrait = height(78)
        guard !isEditable else { return }
        textField.addGestureRecognizer(tappedGesture)
    }

    final func updateBorder(_ isValid: Bool) {
        if isUpdatesBorderColor {
            textField.layer.borderColor = isValid ? successBorderColor : failureBorderColor
        } else {
            textField.layer.borderColor = UIColor.primaryInputTitle.cgColor
        }
    }

    final func updateDefaultBorder() {
        textField.layer.borderColor = UIColor.primaryInputTitle.cgColor
    }

    final func configureTextField() {
        textField.validateHandler = { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                self.hideError()
                updateDefaultBorder()

            case .error(let error):
                self.updateBorder(false)
                self.showError(error)
            }
        }
    }

    final func showError(_ text: String?) {
        guard let text else { return }
        errorLabel.isHidden = false
        errorLabel.text = text
        heightConstrait?.constant = 116
    }

    final func hideError() {
        errorLabel.isHidden = true
        heightConstrait?.constant = 78
    }
}

// MARK: - UITextFieldDelegate
extension InputView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
        updateBorder(true)
        didBeginEditing?(textField.text)
    }

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let limit else { return true }
        return range.location < limit
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    public func clearText() {
        textField.text = nil
        hideError()
        updateDefaultBorder()
        textField.attributedPlaceholder = placeHolderAttributed.attributedString
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        if validateOnFocusLost && !didLoseFocusOnce {
            self.textField.validate()
            didLoseFocusOnce = true
        }

        guard textField.text?.isEmpty ?? true else { return }
        textField.attributedPlaceholder = placeHolderAttributed.attributedString
    }
}

// MARK: - Actions
extension InputView {
    @objc private func textFieldTapped() {
        didBeginEditing?(textField.text)
    }
}
