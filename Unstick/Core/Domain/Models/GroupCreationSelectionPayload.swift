//
//  GroupCreationSelectionPayload.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Сериализуемая модель выбора приложений в create-group сессии.
struct GroupCreationSelectionPayload: Codable, Equatable {
    var selectedAppIDs: [UUID]
    var summary: SelectionSummary?

    var isEmpty: Bool {
        if let summary {
            return summary.isEmpty
        }
        return selectedAppIDs.isEmpty
    }
}
