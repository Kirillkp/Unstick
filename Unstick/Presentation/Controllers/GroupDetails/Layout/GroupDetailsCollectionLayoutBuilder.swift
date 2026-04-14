//
//  GroupDetailsCollectionLayoutBuilder.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit

enum GroupDetailsCollectionLayoutBuilder {
    private enum Layout {
        static let statusControlEstimatedHeight: CGFloat = 150
        static let usageSummaryEstimatedHeight: CGFloat = 140
        static let settingsHeaderEstimatedHeight: CGFloat = 44
        static let groupNameEstimatedHeight: CGFloat = 170
        static let dailyLimitEstimatedHeight: CGFloat = 340
        static let breakSettingsEstimatedHeight: CGFloat = 380
        static let onDemandEstimatedHeight: CGFloat = 340
        static let appsHeaderEstimatedHeight: CGFloat = 44
        static let appsListEstimatedHeight: CGFloat = 260
        static let updateActionEstimatedHeight: CGFloat = 64
        static let deleteActionEstimatedHeight: CGFloat = 64
    }

    static func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = GroupDetailsCollectionSection(rawValue: sectionIndex) else {
                return nil
            }

            switch section {
            case .statusControl:
                return makeSection(
                    estimatedHeight: Layout.statusControlEstimatedHeight,
                    topInset: DS.Spacing.x24
                )
            case .usageSummary:
                return makeSection(
                    estimatedHeight: Layout.usageSummaryEstimatedHeight,
                    topInset: DS.Spacing.x20
                )
            case .settingsHeader:
                return makeSection(
                    estimatedHeight: Layout.settingsHeaderEstimatedHeight,
                    topInset: DS.Spacing.x20
                )
            case .groupName:
                return makeSection(
                    estimatedHeight: Layout.groupNameEstimatedHeight,
                    topInset: DS.Spacing.x12
                )
            case .dailyLimit:
                return makeSection(
                    estimatedHeight: Layout.dailyLimitEstimatedHeight,
                    topInset: DS.Spacing.x20
                )
            case .breakSettings:
                return makeSection(
                    estimatedHeight: Layout.breakSettingsEstimatedHeight,
                    topInset: DS.Spacing.x20
                )
            case .onDemand:
                return makeSection(
                    estimatedHeight: Layout.onDemandEstimatedHeight,
                    topInset: DS.Spacing.x20
                )
            case .appsHeader:
                return makeSection(
                    estimatedHeight: Layout.appsHeaderEstimatedHeight,
                    topInset: DS.Spacing.x20
                )
            case .appsList:
                return makeSection(
                    estimatedHeight: Layout.appsListEstimatedHeight,
                    topInset: DS.Spacing.x12
                )
            case .deleteAction:
                return makeSection(
                    estimatedHeight: Layout.deleteActionEstimatedHeight,
                    topInset: DS.Spacing.x16
                )
            case .updateAction:
                return makeSection(
                    estimatedHeight: Layout.updateActionEstimatedHeight,
                    topInset: DS.Spacing.x32
                )
            }
        }
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
