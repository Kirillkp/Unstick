//
//  StatisticsCollectionLayoutBuilder.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit

enum StatisticsCollectionLayoutBuilder {
    private enum Layout {
        static let heroEstimatedHeight: CGFloat = 180
        static let metricsEstimatedHeight: CGFloat = 112
        static let activityEstimatedHeight: CGFloat = 220
        static let analysisEstimatedHeight: CGFloat = 98
    }

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = StatisticsCollectionSection(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .hero:
                return makeFullWidthSection(
                    estimatedHeight: Layout.heroEstimatedHeight,
                    topInset: DS.Spacing.x24,
                    bottomInset: DS.Spacing.x24
                )
            case .metrics:
                return makeMetricsSection()
            case .activity:
                return makeFullWidthSection(
                    estimatedHeight: Layout.activityEstimatedHeight,
                    topInset: 0,
                    bottomInset: DS.Spacing.x24
                )
            case .analysis:
                return makeFullWidthSection(
                    estimatedHeight: Layout.analysisEstimatedHeight,
                    topInset: 0,
                    bottomInset: DS.Spacing.x16,
                    interGroupSpacing: DS.Spacing.x12
                )
            }
        }
    }

    private static func makeFullWidthSection(
        estimatedHeight: CGFloat,
        topInset: CGFloat,
        bottomInset: CGFloat,
        interGroupSpacing: CGFloat = 0
    ) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(estimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(estimatedHeight)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = interGroupSpacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: topInset,
            leading: DS.Spacing.x24,
            bottom: bottomInset,
            trailing: DS.Spacing.x24
        )
        return section
    }

    private static func makeMetricsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(Layout.metricsEstimatedHeight)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(Layout.metricsEstimatedHeight)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item]
        )
        group.interItemSpacing = .fixed(DS.Spacing.x12)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = DS.Spacing.x12
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: DS.Spacing.x24,
            bottom: DS.Spacing.x24,
            trailing: DS.Spacing.x24
        )
        return section
    }
}
