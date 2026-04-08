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

    func makeFilledCollectionContent(
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
