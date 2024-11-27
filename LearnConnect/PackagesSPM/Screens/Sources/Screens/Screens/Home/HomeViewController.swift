//
//  HomeViewController.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Managers
import TinyConstraints
import Utilities
import Resources
import UIComponents

public final class HomeViewController: BaseViewController<HomeViewModel> {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delaysContentTouches = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }
        tableView.sectionFooterHeight = .zero
        tableView.sectionHeaderHeight = .zero
        tableView.contentInset = .init(
            top: .zero,
            left: .zero,
            bottom: .defaultBottomPadding,
            right: .zero
        )
        tableView.register(CourceCell.self)
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        configureLocalize()
        subscribeViewModel()
        viewModel.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override var screenName: String? {
        return ScreenNameConstants.home
    }
}

// MARK: - UILayout
extension HomeViewController {
    
    final func addSubViews() {
        addTableView()
    }
    
    final func addTableView() {
        view.addSubview(tableView)
        tableView.edgesToSuperview(excluding: .top)
        tableView.topToSuperview(usingSafeArea: true)
    }
}

// MARK: - ConfigureContents
extension HomeViewController {
    
    final func configureContents() {
        configureViewController()
        backButtonIsHidden = true
    }
    
    final func configureViewController() {
        
    }
}

// MARK: ConfigureLocalize
extension HomeViewController {
    
    final func configureLocalize() {
        
    }
}

// MARK: SubscribeViewModel
extension HomeViewController {
    
    final func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self else { return }
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        viewModel.didSelectRowAt(indexPath: indexPath)
    }
    
    public func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    public func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.numberOfRowsInSection
    }

    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell: CourceCell = tableView.dequeueReusableCell(for: indexPath)
        cell.isHiddeButton = false
        cell.delegate = self
        let cellModel = viewModel.cellForRowAt(indexPath: indexPath)
        cell.set(viewModel: cellModel)
        return cell
    }
}

// MARK: - CourceCellDelegate
extension HomeViewController: CourceCellDelegate {
    public func didTappedRegister(_ cellModel: CourceCellProtocol) {
        viewModel.didTappedRegister(cellModel)
    }
}
