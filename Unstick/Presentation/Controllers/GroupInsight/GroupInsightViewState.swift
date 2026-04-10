//
//  GroupInsightViewState.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

enum GroupInsightViewState {
    case filled(
        hero: HeroSectionModel,
        primaryActionTitle: String,
        activity: WeeklyActivityCardModel,
        topAppsHeader: MainGroupsSectionHeaderModel,
        topApps: [UsageSummaryCardModel]
    )
}
