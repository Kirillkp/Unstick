//
//  MainCollectionLayoutBuilder.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import UIKit

enum MainCollectionLayoutBuilder {
    private enum Layout {
        static let itemEstimatedHeight: CGFloat = 136
        static let actionButtonEstimatedHeight: CGFloat = 64
        static let headerEstimatedHeight: CGFloat = 56
    }

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = MainCollectionSection(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .usageSummary:
                return makeUsageSummarySection()
            case .actionButton:
                return makeActionButtonSection()
            }
        }
    }

    private static func makeUsageSummarySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.itemEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.itemEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = DS.Spacing.x16
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x16,
            trailing: DS.Spacing.x24
        )

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(Layout.headerEstimatedHeight)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [header]

        return section
    }

    private static func makeActionButtonSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.actionButtonEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.actionButtonEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: DS.Spacing.x24,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x16,
            trailing: DS.Spacing.x24
        )

        return section
    }
}
