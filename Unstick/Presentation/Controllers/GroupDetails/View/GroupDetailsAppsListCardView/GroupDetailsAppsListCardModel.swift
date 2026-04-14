//
//  GroupDetailsAppsListCardModel.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit

nonisolated struct GroupDetailsAppsListCardModel: BaseCellViewModel, @unchecked Sendable {
    struct Row: Hashable, @unchecked Sendable {
        let id: UUID
        let icon: UIImage?
        let name: String
        let usageText: String

        init(
            id: UUID = UUID(),
            icon: UIImage?,
            name: String,
            usageText: String
        ) {
            self.id = id
            self.icon = icon
            self.name = name
            self.usageText = usageText
        }

        nonisolated static func == (
            lhs: GroupDetailsAppsListCardModel.Row,
            rhs: GroupDetailsAppsListCardModel.Row
        ) -> Bool {
            lhs.id == rhs.id
                && lhs.name == rhs.name
                && lhs.usageText == rhs.usageText
        }

        nonisolated func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(name)
            hasher.combine(usageText)
        }
    }

    let id: UUID
    let rows: [Row]

    init(
        id: UUID = UUID(),
        rows: [Row]
    ) {
        self.id = id
        self.rows = rows
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<GroupDetailsAppsListCardView>.self)
    }

    nonisolated static func == (
        lhs: GroupDetailsAppsListCardModel,
        rhs: GroupDetailsAppsListCardModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.rows == rhs.rows
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(rows)
    }
}
