//
//  AppSelectionFactory.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

final class AppSelectionFactory: AppSelectionFactoryProtocol {
    func makeCollectionContent(
        summary: SelectionSummary
    ) -> [AnyCollectionSection] {
        let hero = makeHeroModel(summary: summary)

        return [
            AnyCollectionSection(
                id: AppSelectionCollectionSection.hero,
                identifier: AppSelectionCollectionSection.hero.sectionIdentifier,
                items: [AnyCollectionItem(hero)]
            )
        ]
    }
}

private extension AppSelectionFactory {
    func makeHeroModel(summary: SelectionSummary) -> HeroSectionModel {
        HeroSectionModel(
            title: L10n.AppSelection.Hero.title,
            subtitle: makeSummaryText(summary: summary)
        )
    }

    func makeSummaryText(summary: SelectionSummary) -> String {
        let selectedCount = L10n.AppSelection.Category.selectedCountFormat(arg0: summary.totalCount)
        return "\(L10n.AppSelection.Hero.subtitle)\n\n\(selectedCount)"
    }
}
