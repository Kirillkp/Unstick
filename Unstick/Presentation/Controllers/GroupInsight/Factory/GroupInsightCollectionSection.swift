//
//  GroupInsightCollectionSection.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

nonisolated enum GroupInsightCollectionSection: Int, CaseIterable, SectionIdentifiable {
    case hero
    case primaryAction
    case activity
    case topApps

    var sectionIdentifier: String {
        "\(rawValue)"
    }
}
