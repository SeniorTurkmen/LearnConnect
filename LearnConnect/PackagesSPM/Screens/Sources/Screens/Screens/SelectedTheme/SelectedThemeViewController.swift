//
//  SelectedThemeViewController.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Managers
import Utilities
import DataProvider
import UIComponents
import Resources

public final class SelectedThemeViewController: BaseViewController<SelectedThemeViewModel> {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryContainerColor
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(20)
        label.textColor = .primaryInputTitle
        label.textAlignment = .center
        label.text = "Change Theme"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ThemeCell.self)
        return collectionView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        subscribeViewModel()
        viewModel.viewDidLoad()
    }
}

// MARK: - UILayout
extension SelectedThemeViewController {
    
    private func addSubViews() {
        addContainerView()
        addTitleLabel()
        addCollectionView()
    }
    
    private func addContainerView() {
        view.addSubview(containerView)
        containerView.edgesToSuperview(usingSafeArea: false)
    }
    
    private func addTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.edgesToSuperview(excluding: .bottom, insets: .top(32))
    }
    
    private func addCollectionView() {
        containerView.addSubview(collectionView)
        collectionView.edgesToSuperview(excluding: .top)
        collectionView.topToBottom(of: titleLabel, offset: 8)
    }
}

// MARK: - ConfigureContents
extension SelectedThemeViewController {
    
    private func configureContents() {
    }

}

// MARK: SubscribeViewModel
extension SelectedThemeViewController {
    
    private func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self else { return }
            self.collectionView.reloadData()
        }
    }
}

// MARK: UICollectionViewDelegate
extension SelectedThemeViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItemAt(indexPath)
    }
}

// MARK: UICollectionViewDataSource
extension SelectedThemeViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ThemeCell = collectionView.dequeueReusableCell(for: indexPath)
        let viewModel = viewModel.cellForItemAt(indexPath: indexPath)
        cell.set(viewModel: viewModel)
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SelectedThemeViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top:  8, left: 16, bottom: 8, right: 16)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = collectionView.frame
        let widht = (frame.width - 48) / 3
        let height = frame.height * 0.80
        return .init(width: widht, height: height)
    }
}
