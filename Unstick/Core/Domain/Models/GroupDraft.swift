//
//  GroupDraft.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

struct GroupDraft: Codable, Equatable, Identifiable {
    let id: UUID
    var selectionData: Data?
    var settings: RestrictionSettings
    let createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        selectionData: Data? = nil,
        settings: RestrictionSettings,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.selectionData = selectionData
        self.settings = settings
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
