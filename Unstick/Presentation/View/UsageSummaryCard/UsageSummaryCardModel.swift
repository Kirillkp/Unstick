//
//  UsageSummaryCardModel.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import UIKit

nonisolated struct UsageSummaryCardModel: Hashable {

    nonisolated enum Style {
        case primary
        case warning
        case danger
    }

    nonisolated struct AppIcon: @unchecked Sendable {
        let image: UIImage?

        init(image: UIImage?) {
            self.image = image
        }
    }

    let id: UUID
    let title: String
    let subtitle: String
    let progress: CGFloat
    let style: Style
    let appIcons: [AppIcon]
    let extraCount: Int?
    let showsWarningIcon: Bool
    let onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        progress: CGFloat,
        style: Style,
        appIcons: [AppIcon],
        extraCount: Int? = nil,
        showsWarningIcon: Bool = false,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.progress = max(0, min(progress, 1))
        self.style = style
        self.appIcons = appIcons
        self.extraCount = extraCount
        self.showsWarningIcon = showsWarningIcon
        self.onTap = onTap
    }

    nonisolated static func == (
        lhs: UsageSummaryCardModel,
        rhs: UsageSummaryCardModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension UsageSummaryCardModel: BaseCellViewModel {
    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<UsageSummaryCardView>.self)
    }
}
