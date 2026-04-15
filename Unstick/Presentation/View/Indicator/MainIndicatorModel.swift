//
//  MainIndicatorModel.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

nonisolated struct IndicatorModel: BaseCellViewModel {
    let id: UUID
    let state: IndicatorView.State

    init(
        id: UUID = UUID(),
        state: IndicatorView.State
    ) {
        self.id = id
        self.state = state
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<IndicatorView>.self)
    }

    nonisolated static func == (
        lhs: IndicatorModel,
        rhs: IndicatorModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
