//
//  UICollectionView+Extensions.swift
//  UIComponents
//
//  Created by Mustafa Turkmen on 25.11.2024.
//

import UIKit

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    func registerHeader<T: UICollectionReusableView>(_: T.Type) where T: ReusableView {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.reuseIdentifier
        )
    }

    func registerFooter<T: UICollectionReusableView>(_: T.Type) where T: ReusableView {
        register(
            T.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.reuseIdentifier
        )
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableCell<T: UICollectionReusableView>(
        ofKind: String,
        for indexPath: IndexPath
    ) -> T where T: ReusableView {
        guard let cell = dequeueReusableSupplementaryView(
            ofKind: ofKind,
            withReuseIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}
