//
//  MainFactory.swift
//  Unstick
//
//  Created by Codex on 07.04.2026.
//

import Foundation
import UIKit

final class MainFactory: MainFactoryProtocol {
    var onDidTapActionButton: (() -> Void)?

    func makeEmptyCollectionContent(
        indicatorState: IndicatorView.State,
        emptyState: MainEmptyStateModel
    ) -> [AnyCollectionSection] {
        [
            AnyCollectionSection(
                id: MainCollectionSection.indicator,
                identifier: MainCollectionSection.indicator.sectionIdentifier,
                items: [AnyCollectionItem(IndicatorModel(state: indicatorState))]
            ),
            AnyCollectionSection(
                id: MainCollectionSection.emptyState,
                identifier: MainCollectionSection.emptyState.sectionIdentifier,
                items: [
                    AnyCollectionItem(
                        MainEmptyStateModel(
                            id: emptyState.id,
                            title: emptyState.title,
                            subtitle: emptyState.subtitle,
                            actionTitle: emptyState.actionTitle,
                            onTapAction: onDidTapActionButton
                        )
                    )
                ]
            )
        ]
    }

    func makeFilledCollectionContent(
        indicatorState: IndicatorView.State,
        items: [UsageSummaryCardModel],
        sectionHeader: MainGroupsSectionHeaderModel,
        actionButtonTitle: String
    ) -> [AnyCollectionSection] {
        let usageSummaryRows = items.map { AnyCollectionItem($0) }
        let actionButtonRows = [
            AnyCollectionItem(
                CollectionButtonRowModel(
                    title: actionButtonTitle,
                    image: UIImage(systemName: "plus.circle"),
                    onTap: onDidTapActionButton
                )
            )
        ]

        return [
            AnyCollectionSection(
                id: MainCollectionSection.indicator,
                identifier: MainCollectionSection.indicator.sectionIdentifier,
                items: [AnyCollectionItem(IndicatorModel(state: indicatorState))]
            ),
            AnyCollectionSection(
                id: MainCollectionSection.emptyState,
                identifier: MainCollectionSection.emptyState.sectionIdentifier,
                items: []
            ),
            AnyCollectionSection(
                id: MainCollectionSection.usageSummary,
                identifier: MainCollectionSection.usageSummary.sectionIdentifier,
                supplementaryItem: AnyCollectionSupplementaryItem(sectionHeader),
                items: usageSummaryRows
            ),
            AnyCollectionSection(
                id: MainCollectionSection.actionButton,
                identifier: MainCollectionSection.actionButton.sectionIdentifier,
                items: actionButtonRows
            )
        ]
    }
}
