//
//  RestrictionSetupCollectionSection.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit

nonisolated enum RestrictionSetupCollectionSection: Int, CaseIterable, SectionIdentifiable {
    case hero
    case groupName
    case dailyLimit
    case breakSettings
    case onDemand

    var sectionIdentifier: String {
        "\(rawValue)"
    }
}
