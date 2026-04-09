//
//  StatisticsCollectionSection.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit

nonisolated enum StatisticsCollectionSection: Int, CaseIterable, SectionIdentifiable {
    case hero
    case metrics
    case activity
    case analysis

    var sectionIdentifier: String {
        "\(rawValue)"
    }
}
