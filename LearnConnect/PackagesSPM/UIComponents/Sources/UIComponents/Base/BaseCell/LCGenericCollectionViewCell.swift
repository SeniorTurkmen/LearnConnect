//
//  LCGenericCollectionViewCell.swift
//  A101
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public class LCGenericCollectionViewCell<View: UIView>: UICollectionViewCell, ReusableView {
    // MARK: UI
    public var cellView: View? {
        didSet {
            guard cellView != nil else { return }
            setupViews()
        }
    }

    var prepareViewForReuse: (() -> Void)?

    var top: NSLayoutConstraint?
    var leading: NSLayoutConstraint?
    var trailing: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?

    var insets: UIEdgeInsets = .zero {
        didSet {
            guard cellView != nil else { return }
            if top?.constant != insets.top {
                top?.constant = insets.top
            }
            if leading?.constant != insets.left {
                leading?.constant = insets.left
            }
            if trailing?.constant != -insets.right {
                trailing?.constant = -insets.right
            }
            if bottom?.constant != -insets.bottom {
                bottom?.constant = -insets.bottom
            }
        }
    }

    // MARK: Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
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
        if let leading, let trailing, let top, let bottom {
            NSLayoutConstraint.activate([leading, trailing, top, bottom])
        }

        backgroundColor = .clear
        clipsToBounds = false
        contentView.clipsToBounds = false
        contentView.layer.masksToBounds = false
    }

    public var isHighlightingEnabled = true

    public override var isHighlighted: Bool {
        didSet {
            guard isHighlighted && isHighlightingEnabled else { return }
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            } completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                    self.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        }
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        prepareViewForReuse?()
    }
}
