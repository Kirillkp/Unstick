//
//  StatisticsViewState.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import Foundation

enum StatisticsViewState {
    case filled(Filled)

    struct Filled {
        let hero: HeroSectionModel
        let metrics: [StatisticsMetricCardModel]
        let activity: WeeklyActivityCardModel?
        let analysis: [StatisticsInsightCardModel]
    }
}
