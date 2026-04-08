//
//  ConfigurableView.swift
//  Unstick
//
//  Created by Codex on 07.04.2026.
//

import Foundation
import UIKit

struct CollectionReusableRegistration: @unchecked Sendable {
    let reuseIdentifier: String
    let register: @MainActor (UICollectionView) -> Void

    static func cell<Cell: UICollectionViewCell>(_ cellType: Cell.Type) -> CollectionReusableRegistration {
        .init(reuseIdentifier: cellType.reuseIdentifier) { collectionView in
            collectionView.register(cellType)
        }
    }

    static func supplementaryView<SupplementaryView: UICollectionReusableView>(
        _ supplementaryViewType: SupplementaryView.Type,
        kind: String
    ) -> CollectionReusableRegistration {
        .init(reuseIdentifier: supplementaryViewType.reuseIdentifier) { collectionView in
            collectionView.register(supplementaryViewType, forSupplementaryViewOfKind: kind)
        }
    }
}

protocol BaseCellViewModel: Hashable, Sendable {
    var registration: CollectionReusableRegistration { get }
}

extension BaseCellViewModel {
    var cellIdentifier: String {
        registration.reuseIdentifier
    }
}

protocol ConfigurableView {
    func configure(with model: any BaseCellViewModel)
}
