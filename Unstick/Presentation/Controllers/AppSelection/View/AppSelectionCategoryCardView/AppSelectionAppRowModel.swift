//
//  AppSelectionAppRowModel.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import Foundation

struct AppSelectionAppRowModel: Hashable, @unchecked Sendable {
    let id: UUID
    let iconSystemName: String
    let title: String
    let isSelected: Bool
    let onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        iconSystemName: String,
        title: String,
        isSelected: Bool,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.iconSystemName = iconSystemName
        self.title = title
        self.isSelected = isSelected
        self.onTap = onTap
    }

    static func == (
        lhs: AppSelectionAppRowModel,
        rhs: AppSelectionAppRowModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.iconSystemName == rhs.iconSystemName
            && lhs.title == rhs.title
            && lhs.isSelected == rhs.isSelected
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(iconSystemName)
        hasher.combine(title)
        hasher.combine(isSelected)
    }
}
