//
//  AppSelectionCollectionSection.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

nonisolated enum AppSelectionCollectionSection: Int, CaseIterable, SectionIdentifiable {
    case hero
    case categories

    var sectionIdentifier: String {
        "\(rawValue)"
    }
}
