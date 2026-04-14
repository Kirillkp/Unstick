//
//  GroupDetailsUsageSummaryCardModel.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

nonisolated struct GroupDetailsUsageSummaryCardModel: BaseCellViewModel, @unchecked Sendable {
    let id: UUID
    let title: String
    let valueText: String
    let limitText: String
    let progress: CGFloat

    init(
        id: UUID = UUID(),
        title: String,
        valueText: String,
        limitText: String,
        progress: CGFloat
    ) {
        self.id = id
        self.title = title
        self.valueText = valueText
        self.limitText = limitText
        self.progress = max(0, min(progress, 1))
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<GroupDetailsUsageSummaryCardView>.self)
    }

    nonisolated static func == (
        lhs: GroupDetailsUsageSummaryCardModel,
        rhs: GroupDetailsUsageSummaryCardModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.valueText == rhs.valueText
            && lhs.limitText == rhs.limitText
            && lhs.progress == rhs.progress
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(valueText)
        hasher.combine(limitText)
        hasher.combine(progress)
    }
}

