//
//  BaseURLsViewController.swift
//  LCCore
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit
import Utilities

public class BaseURLsViewController: UIViewController {
    // MARK: UI
    let cellIdentifier = "Cell"

    weak var tableView: UITableView!
    var userDefaults = UserDefaults.standard
    var customURL: String?

    // MARK: Properties
    let config: EnvironmentsConfig

    // MARK: Init
    init(config: EnvironmentsConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "URL Changer"
        setupTableView()
        addCloseButton()
    }

    // MARK: - UI
    private func setupTableView() {
        let style: UITableView.Style
        if #available(iOS 13.0, *) {
            style = .insetGrouped
        } else {
            style = .grouped
        }

        let tableView = UITableView(frame: .zero, style: style)
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 54
        self.tableView = tableView
    }

    private func addCloseButton() {
        let close: UIBarButtonItem
        if #available(iOS 13.0, *) {
            close = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissController))
        } else {
            close = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissController))
        }
        self.navigationItem.rightBarButtonItem = close
    }

    @objc private func dismissController() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension BaseURLsViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return config.services.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        let service = config.services[indexPath.section]
        let url: String = userDefaults.string(forKey: service.type.rawValue) ?? "-"
        let selectedEnv = service.environment(for: url)
        cell.textLabel?.text = selectedEnv?.name.uppercased() ?? "-"
        cell.textLabel?.font = .boldSystemFont(ofSize: 14)
        cell.detailTextLabel?.text = url
        cell.detailTextLabel?.textColor = .darkGray
        cell.detailTextLabel?.minimumScaleFactor = 0.3
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return config.services[section].name
    }
}

extension BaseURLsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let service = config.services[indexPath.section]
        presentEnvironments(for: service, index: indexPath.section)
    }
}

extension BaseURLsViewController {
    func presentEnvironments(for service: LCBaseService, index: Int) {
        let alert = UIAlertController(title: service.name,
                                      message: "Choose environment",
                                      preferredStyle: .actionSheet)
        for environment in service.environments {
            let action = UIAlertAction(title: environment.name,
                                       style: .default) { [weak self] _ in
                if environment.type != .local {
                    self?.userDefaults.setValue(environment.value,
                                                forKey: service.type.rawValue)
                    self?.tableView.reloadData()
                } else {
                    self?.presentTextFieldAlert(for: service, index: index)
                }
            }
            alert.addAction(action)
        }
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }

    func presentTextFieldAlert(for service: LCBaseService, index: Int) {
        let alert = UIAlertController(title: service.name,
                                      message: "Enter custom URL for \(service.name)",
                                      preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = "http://192.168."
            textField.placeholder = "Type here"
            textField.tag = index
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
        }
        let apply = UIAlertAction(title: "Apply", style: .default) { [weak self] _ in
            self?.saveCustomURL(for: service, index: index)
        }
        alert.addAction(apply)
        let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(close)

        present(alert, animated: true, completion: nil)
    }

    @objc func textChanged(_ sender: UITextField) {
        customURL = sender.text?.trimmed
    }

    func saveCustomURL(for service: LCBaseService, index: Int) {
        guard let text = customURL,
              !text.isEmpty,
              text.isValidURLString
        else {
            let alert = UIAlertController(title: "Error",
                                          message: "Invalid URL", preferredStyle: .alert)
            let retry = UIAlertAction(title: "Try again", style: .default) { [weak self] _ in
                self?.presentTextFieldAlert(for: service, index: index)
            }
            alert.addAction(retry)
            let close = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alert.addAction(close)
            present(alert, animated: true, completion: nil)
            return
        }

        self.userDefaults.setValue(text, forKey: service.type.rawValue)
        self.tableView.reloadData()
    }
}
