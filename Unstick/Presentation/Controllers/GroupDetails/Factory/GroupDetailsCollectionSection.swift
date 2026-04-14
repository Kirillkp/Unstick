//
//  GroupDetailsCollectionSection.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit

nonisolated enum GroupDetailsCollectionSection: Int, CaseIterable, SectionIdentifiable {
    case statusControl
    case usageSummary
    case settingsHeader
    case groupName
    case dailyLimit
    case breakSettings
    case onDemand
    case appsHeader
    case appsList
    case deleteAction

    var sectionIdentifier: String {
        "\(rawValue)"
    }
}
