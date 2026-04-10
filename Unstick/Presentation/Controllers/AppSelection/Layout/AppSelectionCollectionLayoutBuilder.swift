//
//  AppSelectionCollectionLayoutBuilder.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

enum AppSelectionCollectionLayoutBuilder {
    private enum Layout {
        static let heroEstimatedHeight: CGFloat = 220
        static let categoryEstimatedHeight: CGFloat = 320
    }

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = AppSelectionCollectionSection(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .hero:
                return makeHeroSection()
            case .categories:
                return makeCategoriesSection()
            }
        }
    }

    private static func makeHeroSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.heroEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.heroEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: DS.Spacing.x24,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x24,
            trailing: DS.Spacing.x24
        )

        return section
    }

    private static func makeCategoriesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.categoryEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.categoryEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = DS.Spacing.x20
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x24,
            trailing: DS.Spacing.x24
        )

        return section
    }
}
