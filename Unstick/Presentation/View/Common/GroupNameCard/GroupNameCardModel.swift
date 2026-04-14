//
//  GroupNameCardModel.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

nonisolated struct GroupNameCardModel: BaseCellViewModel, @unchecked Sendable {
    let id: UUID
    let title: String
    let value: String
    let placeholder: String
    let onValueChanged: ((String) -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        value: String,
        placeholder: String,
        onValueChanged: ((String) -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.value = value
        self.placeholder = placeholder
        self.onValueChanged = onValueChanged
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<GroupNameCardView>.self)
    }

    nonisolated static func == (
        lhs: GroupNameCardModel,
        rhs: GroupNameCardModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.value == rhs.value
            && lhs.placeholder == rhs.placeholder
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(value)
        hasher.combine(placeholder)
    }
}

