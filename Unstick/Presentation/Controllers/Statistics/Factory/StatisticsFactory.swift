//
//  StatisticsFactory.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import Foundation

final class StatisticsFactory: StatisticsFactoryProtocol {
    func makeCollectionContent(for state: StatisticsViewState.Filled) -> [AnyCollectionSection] {
        var sections: [AnyCollectionSection] = [
            AnyCollectionSection(
                id: StatisticsCollectionSection.hero,
                identifier: StatisticsCollectionSection.hero.sectionIdentifier,
                items: [
                    AnyCollectionItem(state.hero)
                ]
            )
        ]

        if !state.metrics.isEmpty {
            sections.append(
                AnyCollectionSection(
                    id: StatisticsCollectionSection.metrics,
                    identifier: StatisticsCollectionSection.metrics.sectionIdentifier,
                    items: state.metrics.map { AnyCollectionItem($0) }
                )
            )
        }

        if let activity = state.activity {
            sections.append(
                AnyCollectionSection(
                    id: StatisticsCollectionSection.activity,
                    identifier: StatisticsCollectionSection.activity.sectionIdentifier,
                    items: [
                        AnyCollectionItem(activity)
                    ]
                )
            )
        }

        if !state.analysis.isEmpty {
            sections.append(
                AnyCollectionSection(
                    id: StatisticsCollectionSection.analysis,
                    identifier: StatisticsCollectionSection.analysis.sectionIdentifier,
                    items: state.analysis.map { AnyCollectionItem($0) }
                )
            )
        }

        return sections
    }
}
