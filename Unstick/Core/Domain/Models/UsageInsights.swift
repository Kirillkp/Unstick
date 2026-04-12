//
//  UsageInsights.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

struct UsageSummary: Codable, Equatable {
    var averageDailyMinutes: Int
    var totalMinutes: Int
}

struct UsageApp: Codable, Equatable, Identifiable {
    let id: UUID
    var title: String
    var usageMinutes: Int

    init(
        id: UUID = UUID(),
        title: String,
        usageMinutes: Int
    ) {
        self.id = id
        self.title = title
        self.usageMinutes = usageMinutes
    }
}
