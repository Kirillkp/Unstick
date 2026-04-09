//
//  StatisticsInsightCardModel.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import Foundation

nonisolated struct StatisticsInsightCardModel: BaseCellViewModel {
    enum Style: Hashable, Sendable {
        case primary
        case neutral
    }

    let id: UUID
    let iconSystemName: String
    let title: String
    let subtitle: String
    let style: Style

    init(
        id: UUID = UUID(),
        iconSystemName: String,
        title: String,
        subtitle: String,
        style: Style
    ) {
        self.id = id
        self.iconSystemName = iconSystemName
        self.title = title
        self.subtitle = subtitle
        self.style = style
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<StatisticsInsightCardView>.self)
    }

    nonisolated static func == (
        lhs: StatisticsInsightCardModel,
        rhs: StatisticsInsightCardModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
