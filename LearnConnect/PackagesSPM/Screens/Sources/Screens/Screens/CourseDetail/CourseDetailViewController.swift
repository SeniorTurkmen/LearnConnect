//
//  CourseDetailViewController.swift
//  Screens
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Managers
import Resources
import Utilities
import UIComponents
import DataProvider

public final class CourseDetailViewController: BaseViewController<CourseDetailViewModel> {
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
        subscribeViewModel()
        viewModel.viewDidLoad()
    }
    
    public override var screenName: String? {
        return ScreenNameConstants.courseDetail
    }
}

// MARK: - UILayout
extension CourseDetailViewController {
    
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
extension CourseDetailViewController {
    
    final func configureContents() {
        configureViewController()
    }
    
    final func configureViewController() {
        navigationItem.title = "Detail"
        backButtonIsHidden = false
    }
}

// MARK: SubscribeViewModel
extension CourseDetailViewController {
    
    final func subscribeViewModel() {
        viewModel.reloadData = { [weak self] in
            guard let self else { return }
            tableView.reloadData()
        }
    }
}


// MARK: - UITableViewDelegate
extension CourseDetailViewController: UITableViewDelegate {
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
extension CourseDetailViewController: UITableViewDataSource {
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
        cell.isHiddeButton = true
        let cellModel = viewModel.cellForRowAt(indexPath: indexPath)
        cell.set(viewModel: cellModel)
        return cell
    }
}
