//
//  AppSelectionFactory.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

final class AppSelectionFactory: AppSelectionFactoryProtocol {
    func makeCollectionContent(
        hero: HeroSectionModel,
        categories: [AppSelectionCategoryCardModel]
    ) -> [AnyCollectionSection] {
        [
            AnyCollectionSection(
                id: AppSelectionCollectionSection.hero,
                identifier: AppSelectionCollectionSection.hero.sectionIdentifier,
                items: [AnyCollectionItem(hero)]
            ),
            AnyCollectionSection(
                id: AppSelectionCollectionSection.categories,
                identifier: AppSelectionCollectionSection.categories.sectionIdentifier,
                items: categories.map { AnyCollectionItem($0) }
            )
        ]
    }
}
