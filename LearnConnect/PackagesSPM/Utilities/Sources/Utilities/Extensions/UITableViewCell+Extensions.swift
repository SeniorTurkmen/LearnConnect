//
//  UITableViewCell+Extensions.swift
//
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public extension UITableViewCell {
    func addToCellDivider(
        bgColor: UIColor,
        leadingInset: CGFloat = .zero,
        trailingInset: CGFloat = .zero
    ) {
        let dividerView = UIView()
        dividerView.backgroundColor = bgColor
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dividerView)
        NSLayoutConstraint.activate([
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leadingInset),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: trailingInset),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
