//
//  AppSelectionCategorySectionInput.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

struct AppSelectionCategorySectionInput {
    let id: UUID
    let iconSystemName: String
    let title: String
    let selectedCount: Int
    let isExpanded: Bool
    let appRows: [AppSelectionAppRowSectionInput]
    let onTap: (() -> Void)?
}
