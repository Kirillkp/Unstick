//
//  RestrictionSetupCollectionLayoutBuilder.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit

enum RestrictionSetupCollectionLayoutBuilder {
    private enum Layout {
        static let heroEstimatedHeight: CGFloat = 200
        static let groupNameEstimatedHeight: CGFloat = 170
        static let dailyLimitEstimatedHeight: CGFloat = 340
        static let breakSettingsEstimatedHeight: CGFloat = 380
        static let onDemandEstimatedHeight: CGFloat = 340
    }

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = RestrictionSetupCollectionSection(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .hero:
                return makeHeroSection()
            case .groupName:
                return makeGroupNameSection()
            case .dailyLimit:
                return makeDailyLimitSection()
            case .breakSettings:
                return makeBreakSettingsSection()
            case .onDemand:
                return makeOnDemandSection()
            }
        }
    }

    private static func makeHeroSection() -> NSCollectionLayoutSection {
        makeSection(
            estimatedHeight: Layout.heroEstimatedHeight,
            topInset: DS.Spacing.x24
        )
    }

    private static func makeGroupNameSection() -> NSCollectionLayoutSection {
        makeSection(
            estimatedHeight: Layout.groupNameEstimatedHeight,
            topInset: DS.Spacing.x20
        )
    }

    private static func makeDailyLimitSection() -> NSCollectionLayoutSection {
        makeSection(
            estimatedHeight: Layout.dailyLimitEstimatedHeight,
            topInset: DS.Spacing.x20
        )
    }

    private static func makeBreakSettingsSection() -> NSCollectionLayoutSection {
        makeSection(
            estimatedHeight: Layout.breakSettingsEstimatedHeight,
            topInset: DS.Spacing.x20
        )
    }

    private static func makeOnDemandSection() -> NSCollectionLayoutSection {
        makeSection(
            estimatedHeight: Layout.onDemandEstimatedHeight,
            topInset: DS.Spacing.x20
        )
    }

    private static func makeSection(
        estimatedHeight: CGFloat,
        topInset: CGFloat
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
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: topInset,
            leading: DS.Spacing.x24,
            bottom: 0,
            trailing: DS.Spacing.x24
        )

        return section
    }
}
