//
//  StatisticsWeeklyActivityModel.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import Foundation

nonisolated struct StatisticsWeeklyActivityModel: BaseCellViewModel {
    nonisolated struct DayActivity: Hashable, Sendable {
        enum Style: Hashable, Sendable {
            case primary
            case accent
            case warning
        }

        let dayTitle: String
        let valueTitle: String
        let value: CGFloat
        let style: Style

        init(
            dayTitle: String,
            valueTitle: String,
            value: CGFloat,
            style: Style
        ) {
            self.dayTitle = dayTitle
            self.valueTitle = valueTitle
            self.value = value
            self.style = style
        }
    }

    let id: UUID
    let title: String
    let subtitle: String
    let items: [DayActivity]

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        items: [DayActivity]
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.items = items
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<StatisticsWeeklyActivityCardView>.self)
    }

    nonisolated static func == (
        lhs: StatisticsWeeklyActivityModel,
        rhs: StatisticsWeeklyActivityModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
