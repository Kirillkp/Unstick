//
//  MainEmptyStateModel.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import Foundation

nonisolated struct MainEmptyStateModel: BaseCellViewModel {
    let id: UUID
    let title: String
    let subtitle: String
    let actionTitle: String
    let onTapAction: (() -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        actionTitle: String,
        onTapAction: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.actionTitle = actionTitle
        self.onTapAction = onTapAction
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<MainEmptyStateView>.self)
    }

    nonisolated static func == (
        lhs: MainEmptyStateModel,
        rhs: MainEmptyStateModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
