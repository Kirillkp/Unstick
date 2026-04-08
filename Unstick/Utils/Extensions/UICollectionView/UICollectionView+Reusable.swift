//
//  UICollectionView+Reusable.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import UIKit

extension UICollectionView {
    func register<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func dequeue<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cellType.reuseIdentifier,
            for: indexPath
        ) as? Cell else {
            fatalError("Failed to dequeue cell with identifier \(cellType.reuseIdentifier)")
        }

        return cell
    }

    func register<SupplementaryView: UICollectionReusableView>(
        _ supplementaryViewType: SupplementaryView.Type,
        forSupplementaryViewOfKind kind: String
    ) {
        register(
            supplementaryViewType,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: supplementaryViewType.reuseIdentifier
        )
    }

    func dequeue<SupplementaryView: UICollectionReusableView>(
        _ supplementaryViewType: SupplementaryView.Type,
        ofKind kind: String,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        guard let supplementaryView = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: supplementaryViewType.reuseIdentifier,
            for: indexPath
        ) as? SupplementaryView else {
            fatalError("Failed to dequeue supplementary view with identifier \(supplementaryViewType.reuseIdentifier)")
        }

        return supplementaryView
    }
}
