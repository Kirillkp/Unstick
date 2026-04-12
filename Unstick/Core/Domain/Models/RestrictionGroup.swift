//
//  RestrictionGroup.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

struct RestrictionGroup: Codable, Equatable, Identifiable {
    let id: UUID
    var selectionData: Data
    var settings: RestrictionSettings
    var status: RestrictionGroupStatus
    let createdAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        selectionData: Data,
        settings: RestrictionSettings,
        status: RestrictionGroupStatus,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.selectionData = selectionData
        self.settings = settings
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum RestrictionGroupStatus: String, Codable, CaseIterable {
    case active
    case paused
    case configurationError
}
