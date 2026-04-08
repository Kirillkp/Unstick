//
//  MainDataSource.swift
//  Unstick
//
//  Created by Codex on 07.04.2026.
//

import UIKit

nonisolated enum MainCollectionSection: Int, CaseIterable, SectionIdentifiable {
    case usageSummary
    case actionButton

    var sectionIdentifier: String {
        "\(rawValue)"
    }
}
