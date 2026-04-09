//
//  SettingsCardModel.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import Foundation

nonisolated struct SettingsCardModel: BaseCellViewModel {
    let id: String
    let title: String
    let rows: [SettingsRowItemModel]

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<SettingsCardView>.self)
    }

    nonisolated static func == (
        lhs: SettingsCardModel,
        rhs: SettingsCardModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
