//
//  MainGroupsSectionHeaderModel.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import UIKit

nonisolated struct MainGroupsSectionHeaderModel: Hashable, Sendable {
    let title: String
    let subtitle: String
}

extension MainGroupsSectionHeaderModel: BaseCellViewModel {
    var registration: CollectionReusableRegistration {
        .supplementaryView(
            MainGroupsSectionHeaderView.self,
            kind: UICollectionView.elementKindSectionHeader
        )
    }
}
