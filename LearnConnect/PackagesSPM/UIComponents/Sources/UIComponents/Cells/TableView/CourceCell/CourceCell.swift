//
//  CourceCell.swift
//  UIComponents
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Resources
import Utilities
import TinyConstraints

public protocol CourceCellDelegate: AnyObject {
    func didTappedRegister(_ cellModel: CourceCellProtocol)
}

public final class CourceCell: UITableViewCell, ReusableView {
    // MARK: - Delegates
    public weak var delegate: CourceCellDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.roundCorners(corners: [.all], radius: 12)
        view.backgroundColor = .primaryContainerColor
        return view
    }()
    
    private lazy var courseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.roundCorners(masksToBounds: true, corners: [.all], radius: 8)
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium(16)
        label.textColor = .white
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .book(14)
        label.textColor = .primarySubTitleColor
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.backgroundColor = .primaryButtonBG.withAlphaComponent(0.4)
        button.titleLabel?.font = .book(12)
        button.roundCorners(corners: [.all], radius: 8)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var viewModel: CourceCellProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        addSubViews()
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureContents()
    }
    
    public var isHiddeButton: Bool = false {
        didSet {
            registerButton.isHidden = isHiddeButton
        }
    }

    public func set(viewModel: CourceCellProtocol?) {
        self.viewModel = viewModel
        configureContents()
    }
}
// MARK: - UILayout
extension CourceCell {
    
    private func addSubViews() {
        addContainerView()
        addCourseImageView()
        addTitleLabel()
        addDescLabel()
        addRegisterButton()
    }
    
    final func addContainerView() {
        contentView.addSubview(containerView)
        containerView.edgesToSuperview(insets: .horizontal(20) + .bottom(12))
    }
    
    final func addCourseImageView() {
        containerView.addSubview(courseImageView)
        courseImageView.leadingToSuperview(offset: 14)
        courseImageView.size(.init(width: 68, height: 68))
        courseImageView.topToSuperview(offset: 14)
    }
    
    final func addTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.leadingToTrailing(of: courseImageView, offset: 35)
        titleLabel.trailingToSuperview()
        titleLabel.topToSuperview(offset: 14)
    }
    
    final func addDescLabel() {
        containerView.addSubview(descLabel)
        descLabel.leadingToTrailing(of: courseImageView, offset: 35)
        descLabel.topToBottom(of: titleLabel, offset: 4)
        descLabel.trailingToSuperview()
    }
    
    final func addRegisterButton() {
        containerView.addSubview(registerButton)
        registerButton.bottomToSuperview(offset: -16)
        registerButton.trailingToSuperview(offset: 24)
        registerButton.size(.init(width: 100, height: 30))
        registerButton.topToBottom(of: descLabel)
    }
}

// MARK: - ConfigureContents
extension CourceCell {
    
    private func configureContents() {
        configureLabels()
        configureImageView()
        configureIsSaved()
    }
    
    final func configureLabels() {
        titleLabel.text = viewModel?.name
        descLabel.text = viewModel?.desc
    }
    
    final func configureImageView() {
        courseImageView.setImage(viewModel?.image)
    }
    
    final func configureIsSaved() {
        guard let saved = viewModel?.isSaved else { return }
        switch saved {
        case true:
            registerButton.isEnabled = false
            registerButton.setTitle("Registered", for: .normal)
        case false:
            registerButton.isEnabled = true
            registerButton.setTitle("Register", for: .normal)
        }
    }
}

// MARK: - Actions
extension CourceCell {
    @objc private func registerButtonTapped() {
        guard let viewModel else { return }
        delegate?.didTappedRegister(viewModel)
    }
}
