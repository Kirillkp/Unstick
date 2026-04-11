//
//  RestrictionSetupFactory.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import Foundation

final class RestrictionSetupFactory: RestrictionSetupFactoryProtocol {
    func makeCollectionContent(
        hero: HeroSectionModel,
        groupName: RestrictionSetupGroupNameCardModel,
        dailyLimit: RestrictionSetupDailyLimitCardModel,
        breakSettings: RestrictionSetupBreakCardModel,
        onDemand: RestrictionSetupOnDemandCardModel
    ) -> [AnyCollectionSection] {
        [
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.hero,
                identifier: RestrictionSetupCollectionSection.hero.sectionIdentifier,
                items: [AnyCollectionItem(hero)]
            ),
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.groupName,
                identifier: RestrictionSetupCollectionSection.groupName.sectionIdentifier,
                items: [AnyCollectionItem(groupName)]
            ),
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.dailyLimit,
                identifier: RestrictionSetupCollectionSection.dailyLimit.sectionIdentifier,
                items: [AnyCollectionItem(dailyLimit)]
            ),
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.breakSettings,
                identifier: RestrictionSetupCollectionSection.breakSettings.sectionIdentifier,
                items: [AnyCollectionItem(breakSettings)]
            ),
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.onDemand,
                identifier: RestrictionSetupCollectionSection.onDemand.sectionIdentifier,
                items: [AnyCollectionItem(onDemand)]
            )
        ]
    }
}
