//
//  AppSelectionCategoryCardModel.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

nonisolated struct AppSelectionCategoryCardModel: BaseCellViewModel, @unchecked Sendable {
    let id: UUID
    let iconSystemName: String
    let title: String
    let subtitle: String
    let isExpanded: Bool
    let appRows: [AppSelectionAppRowModel]
    let onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        iconSystemName: String,
        title: String,
        subtitle: String,
        isExpanded: Bool = false,
        appRows: [AppSelectionAppRowModel] = [],
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.iconSystemName = iconSystemName
        self.title = title
        self.subtitle = subtitle
        self.isExpanded = isExpanded
        self.appRows = appRows
        self.onTap = onTap
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<AppSelectionCategoryCardView>.self)
    }

    nonisolated static func == (
        lhs: AppSelectionCategoryCardModel,
        rhs: AppSelectionCategoryCardModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.subtitle == rhs.subtitle
            && lhs.isExpanded == rhs.isExpanded
            && lhs.appRows == rhs.appRows
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(subtitle)
        hasher.combine(isExpanded)
        hasher.combine(appRows)
    }
}
