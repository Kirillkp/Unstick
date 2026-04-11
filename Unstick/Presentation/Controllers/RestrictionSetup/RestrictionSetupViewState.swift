//
//  RestrictionSetupViewState.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import Foundation

enum RestrictionSetupViewState {
    case filled(
        hero: HeroSectionModel,
        groupName: RestrictionSetupGroupNameCardModel,
        dailyLimit: RestrictionSetupDailyLimitCardModel,
        breakSettings: RestrictionSetupBreakCardModel,
        onDemand: RestrictionSetupOnDemandCardModel,
        continueTitle: String,
        isContinueEnabled: Bool
    )
}
