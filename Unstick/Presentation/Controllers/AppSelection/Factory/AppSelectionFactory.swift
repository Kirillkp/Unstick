//
//  AppSelectionFactory.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

final class AppSelectionFactory: AppSelectionFactoryProtocol {
    func makeCollectionContent(
        categories: [AppSelectionCategorySectionInput]
    ) -> [AnyCollectionSection] {
        let hero = makeHeroModel()
        let categoryCardModels = categories.map(makeCategoryCardModel)

        return [
            AnyCollectionSection(
                id: AppSelectionCollectionSection.hero,
                identifier: AppSelectionCollectionSection.hero.sectionIdentifier,
                items: [AnyCollectionItem(hero)]
            ),
            AnyCollectionSection(
                id: AppSelectionCollectionSection.categories,
                identifier: AppSelectionCollectionSection.categories.sectionIdentifier,
                items: categoryCardModels.map { AnyCollectionItem($0) }
            )
        ]
    }
}

private extension AppSelectionFactory {
    func makeCategoryCardModel(_ input: AppSelectionCategorySectionInput) -> AppSelectionCategoryCardModel {
        AppSelectionCategoryCardModel(
            id: input.id,
            iconSystemName: input.iconSystemName,
            title: input.title,
            subtitle: makeCategorySubtitle(selectedCount: input.selectedCount),
            isExpanded: input.isExpanded,
            appRows: input.appRows.map(makeAppRowModel),
            onTap: input.onTap
        )
    }

    func makeAppRowModel(_ input: AppSelectionAppRowSectionInput) -> AppSelectionAppRowModel {
        AppSelectionAppRowModel(
            id: input.id,
            iconSystemName: input.iconSystemName,
            title: input.title,
            isSelected: input.isSelected,
            onTap: input.onTap
        )
    }

    func makeCategorySubtitle(selectedCount: Int) -> String {
        L10n.AppSelection.Category.selectedCountFormat(arg0: selectedCount)
    }

    func makeHeroModel() -> HeroSectionModel {
        HeroSectionModel(
            title: L10n.AppSelection.Hero.title,
            subtitle: L10n.AppSelection.Hero.subtitle
        )
    }
}
