//
//  ThemeCell.swift
//  UIComponents
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Resources
import Utilities

public class ThemeCell: UICollectionViewCell, ReusableView {
    
    private let themeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .bold(12)
        label.textColor = .primaryInputTitle
        label.textAlignment = .center
        return label
    }()
    
    private let checkMarkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .imgCheckmarkCircleFill.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .green
        imageView.isHidden = true
        return imageView
    }()
    
    weak var viewModel: ThemeCellProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        configureContents()
        configureLocalize()
        addTargets()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContents()
    }

    public func set(viewModel: ThemeCellProtocol?) {
        self.viewModel = viewModel
        configureContents()
    }
}

// MARK: - UILayout
extension ThemeCell {
    
    private func addSubViews() {
        addImageView()
        addTitleLabel()
        addCheckMarkImage()
    }
    
    private func addImageView() {
        contentView.addSubview(themeImageView)
        themeImageView.edgesToSuperview(excluding: .bottom, insets: .top(16))
        themeImageView.height(150)
    }

    private func addTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.horizontalToSuperview()
        titleLabel.topToBottom(of: themeImageView, offset: 16)
        titleLabel.centerX(to: themeImageView)
        titleLabel.bottomToSuperview(offset: 8, relation: .equalOrLess)
    }
    
    private func addCheckMarkImage() {
        themeImageView.addSubview(checkMarkImage)
        checkMarkImage.centerInSuperview()
        checkMarkImage.size(.init(width: 24, height: 24))
    }
}

// MARK: - ConfigureContents
extension ThemeCell {
    
    private func configureContents() {
        configreImageView()
        configureTitleLabel()
        configureCheckMarkImage()
    }

    private func configreImageView() {
        themeImageView.image = viewModel?.image
    }
    
    private func configureTitleLabel() {
        titleLabel.text = viewModel?.title
    }
    
    private func configureCheckMarkImage() {
        guard let isSelected = viewModel?.isSelected else { return }
        checkMarkImage.isHidden = !isSelected
    }
}

// MARK: ConfigureLocalize
extension ThemeCell {
    
    private func configureLocalize() {
        
    }
}

// MARK: AddTargest
extension ThemeCell {
    
    private func addTargets() {
        
    }
}

// MARK: Actions
extension ThemeCell {}
