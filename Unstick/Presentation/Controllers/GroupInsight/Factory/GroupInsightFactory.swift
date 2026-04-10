//
//  GroupInsightFactory.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation
import UIKit

final class GroupInsightFactory: GroupInsightFactoryProtocol {
    var onDidTapPrimaryAction: (() -> Void)?

    func makeCollectionContent(
        hero: HeroSectionModel,
        primaryActionTitle: String,
        activity: WeeklyActivityCardModel,
        topAppsHeader: MainGroupsSectionHeaderModel,
        topApps: [UsageSummaryCardModel]
    ) -> [AnyCollectionSection] {
        [
            AnyCollectionSection(
                id: GroupInsightCollectionSection.hero,
                identifier: GroupInsightCollectionSection.hero.sectionIdentifier,
                items: [AnyCollectionItem(hero)]
            ),
            AnyCollectionSection(
                id: GroupInsightCollectionSection.primaryAction,
                identifier: GroupInsightCollectionSection.primaryAction.sectionIdentifier,
                items: [
                    AnyCollectionItem(
                        CollectionButtonRowModel(
                            title: primaryActionTitle,
                            buttonStyle: .primary,
                            buttonSize: .xl,
                            onTap: onDidTapPrimaryAction
                        )
                    )
                ]
            ),
            AnyCollectionSection(
                id: GroupInsightCollectionSection.activity,
                identifier: GroupInsightCollectionSection.activity.sectionIdentifier,
                items: [AnyCollectionItem(activity)]
            ),
            AnyCollectionSection(
                id: GroupInsightCollectionSection.topApps,
                identifier: GroupInsightCollectionSection.topApps.sectionIdentifier,
                supplementaryItem: AnyCollectionSupplementaryItem(topAppsHeader),
                items: topApps.map { AnyCollectionItem($0) }
            )
        ]
    }
}
