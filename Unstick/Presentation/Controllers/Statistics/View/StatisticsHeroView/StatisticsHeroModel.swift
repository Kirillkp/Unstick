//
//  StatisticsHeroModel.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import Foundation

nonisolated struct StatisticsHeroModel: BaseCellViewModel {
    let id: UUID
    let badge: String
    let title: String
    let highlightedHours: String
    let highlightedMinutes: String
    let subtitle: String

    init(
        id: UUID = UUID(),
        badge: String,
        title: String,
        highlightedHours: String,
        highlightedMinutes: String,
        subtitle: String
    ) {
        self.id = id
        self.badge = badge
        self.title = title
        self.highlightedHours = highlightedHours
        self.highlightedMinutes = highlightedMinutes
        self.subtitle = subtitle
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<StatisticsHeroView>.self)
    }

    nonisolated static func == (
        lhs: StatisticsHeroModel,
        rhs: StatisticsHeroModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
