//
//  SettingsCollectionLayoutBuilder.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit

enum SettingsCollectionLayoutBuilder {
    private enum Layout {
        static let cardEstimatedHeight: CGFloat = 180
        static let headerHeight: CGFloat = 22
    }

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = SettingsCollectionSection(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .general:
                return makeCardSection(topInset: 0)
            case .protection:
                return makeCardSection(topInset: 0)
            case .personalization:
                return makeCardSection(topInset: 0)
            case .support:
                return makeCardSection(topInset: 0)
            case .about:
                return makeCardSection(topInset: 0)
            }
        }
    }

    private static func makeCardSection(topInset: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.cardEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.cardEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [makeHeader()]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: topInset,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x24,
            trailing: DS.Spacing.x24
        )
        return section
    }

    private static func makeHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(Layout.headerHeight)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}
