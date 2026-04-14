//
//  GroupDetailsStatusControlCardModel.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

nonisolated struct GroupDetailsStatusControlCardModel: BaseCellViewModel, @unchecked Sendable {
    let id: UUID
    let isActive: Bool
    let title: String
    let subtitle: String
    let actionTitle: String
    let onTapAction: (() -> Void)?

    init(
        id: UUID = UUID(),
        isActive: Bool,
        title: String,
        subtitle: String,
        actionTitle: String,
        onTapAction: (() -> Void)? = nil
    ) {
        self.id = id
        self.isActive = isActive
        self.title = title
        self.subtitle = subtitle
        self.actionTitle = actionTitle
        self.onTapAction = onTapAction
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<GroupDetailsStatusControlCardView>.self)
    }

    nonisolated static func == (
        lhs: GroupDetailsStatusControlCardModel,
        rhs: GroupDetailsStatusControlCardModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.isActive == rhs.isActive
            && lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.actionTitle == rhs.actionTitle
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isActive)
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(actionTitle)
    }
}

