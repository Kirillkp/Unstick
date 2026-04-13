//
//  UsageInsights.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

enum UsageWeekday: String, Codable, CaseIterable {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
}

struct UsageDayActivity: Codable, Equatable, Identifiable {
    let id: UUID
    var weekday: UsageWeekday
    var usageMinutes: Int

    init(
        id: UUID = UUID(),
        weekday: UsageWeekday,
        usageMinutes: Int
    ) {
        self.id = id
        self.weekday = weekday
        self.usageMinutes = usageMinutes
    }
}

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
