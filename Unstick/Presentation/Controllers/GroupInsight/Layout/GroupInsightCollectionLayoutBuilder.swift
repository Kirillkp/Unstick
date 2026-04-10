//
//  GroupInsightCollectionLayoutBuilder.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

enum GroupInsightCollectionLayoutBuilder {
    private enum Layout {
        static let heroEstimatedHeight: CGFloat = 260
        static let primaryActionEstimatedHeight: CGFloat = 64
        static let activityEstimatedHeight: CGFloat = 270
        static let topAppsItemEstimatedHeight: CGFloat = 112
        static let topAppsHeaderEstimatedHeight: CGFloat = 56
    }

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = GroupInsightCollectionSection(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .hero:
                return makeHeroSection()
            case .primaryAction:
                return makePrimaryActionSection()
            case .activity:
                return makeActivitySection()
            case .topApps:
                return makeTopAppsSection()
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
            bottom: DS.Spacing.x32,
            trailing: DS.Spacing.x24
        )

        return section
    }

    private static func makePrimaryActionSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.primaryActionEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.primaryActionEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x32,
            trailing: DS.Spacing.x24
        )

        return section
    }

    private static func makeActivitySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.activityEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.activityEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x24,
            trailing: DS.Spacing.x24
        )

        return section
    }

    private static func makeTopAppsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.topAppsItemEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.topAppsItemEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = DS.Spacing.x16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x24,
            trailing: DS.Spacing.x24
        )

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.topAppsHeaderEstimatedHeight)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }
}
