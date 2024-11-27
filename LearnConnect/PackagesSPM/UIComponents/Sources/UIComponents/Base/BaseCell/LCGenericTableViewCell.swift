//
//  LCGenericTableViewCell.swift
//  A101
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable unused_optional_binding
public class LCGenericTableViewCell<View: UIView>: UITableViewCell, ReusableView {
    // MARK: UI
    public var cellView: View? {
        didSet {
            guard cellView != nil else { return }
            setupViews()
        }
    }

    var top: NSLayoutConstraint!
    var leading: NSLayoutConstraint!
    var trailing: NSLayoutConstraint!
    var bottom: NSLayoutConstraint!

     public var insets: UIEdgeInsets = .zero {
        didSet {
            guard let _ = cellView else { return }
            if top.constant != insets.top {
                top.constant = insets.top
            }
            if leading.constant != insets.left {
                leading.constant = insets.left
            }
            if trailing.constant != -insets.right {
                trailing.constant = -insets.right
            }
            if bottom.constant != -insets.bottom {
                bottom.constant = -insets.bottom
            }
        }
    }

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    private func setupViews() {
        guard let cellView = cellView else { return }

        contentView.addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false

        leading = cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        trailing = cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        top = cellView.topAnchor.constraint(equalTo: contentView.topAnchor)
        bottom = cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)

        NSLayoutConstraint.activate([leading, trailing, top, bottom])

        backgroundColor = .clear
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
        selectionStyle = .none
    }
}
// swiftlint:enable implicitly_unwrapped_optional
// swiftlint:enable unused_optional_binding
