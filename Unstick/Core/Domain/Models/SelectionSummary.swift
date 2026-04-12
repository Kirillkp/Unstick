//
//  SelectionSummary.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

struct SelectionSummary: Codable, Equatable {
    var selectedApplicationsCount: Int
    var selectedCategoriesCount: Int
    var selectedWebDomainsCount: Int

    var totalCount: Int {
        selectedApplicationsCount + selectedCategoriesCount + selectedWebDomainsCount
    }

    var isEmpty: Bool {
        totalCount == 0
    }
}
