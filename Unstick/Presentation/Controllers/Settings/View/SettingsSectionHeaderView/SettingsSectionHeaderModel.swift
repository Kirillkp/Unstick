//
//  SettingsSectionHeaderModel.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit

nonisolated struct SettingsSectionHeaderModel: Hashable, Sendable {
    let title: String
}

extension SettingsSectionHeaderModel: BaseCellViewModel {
    var registration: CollectionReusableRegistration {
        .supplementaryView(
            SettingsSectionHeaderView.self,
            kind: UICollectionView.elementKindSectionHeader
        )
    }
}
