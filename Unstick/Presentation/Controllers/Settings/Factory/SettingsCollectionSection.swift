//
//  SettingsCollectionSection.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit

nonisolated enum SettingsCollectionSection: Int, CaseIterable, SectionIdentifiable {
    case general
    case protection
    case personalization
    case support
    case about

    var sectionIdentifier: String {
        "\(rawValue)"
    }
}
