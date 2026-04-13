//
//  AppSelectionAppRowSectionInput.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

struct AppSelectionAppRowSectionInput {
    let id: UUID
    let iconSystemName: String
    let title: String
    let isSelected: Bool
    let onTap: (() -> Void)?
}
