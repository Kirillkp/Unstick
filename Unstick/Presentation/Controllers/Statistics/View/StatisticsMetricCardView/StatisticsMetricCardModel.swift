//
//  StatisticsMetricCardModel.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import Foundation

nonisolated struct StatisticsMetricCardModel: BaseCellViewModel {
    let id: UUID
    let iconSystemName: String
    let title: String
    let value: String

    init(
        id: UUID = UUID(),
        iconSystemName: String,
        title: String,
        value: String
    ) {
        self.id = id
        self.iconSystemName = iconSystemName
        self.title = title
        self.value = value
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<StatisticsMetricCardView>.self)
    }

    nonisolated static func == (
        lhs: StatisticsMetricCardModel,
        rhs: StatisticsMetricCardModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
