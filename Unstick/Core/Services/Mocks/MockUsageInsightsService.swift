//
//  MockUsageInsightsService.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Mock-реализация агрегированной статистики для GroupInsight.
final class MockUsageInsightsService: IUsageInsightsService {
    private let summary: UsageSummary?
    private let weeklyActivityItems: [UsageDayActivity]
    private let apps: [UsageApp]

    init(
        summary: UsageSummary? = .init(averageDailyMinutes: 174, totalMinutes: 1218),
        weeklyActivityItems: [UsageDayActivity] = [
            .init(weekday: .mon, usageMinutes: 234),
            .init(weekday: .tue, usageMinutes: 72),
            .init(weekday: .wed, usageMinutes: 167),
            .init(weekday: .thu, usageMinutes: 159),
            .init(weekday: .fri, usageMinutes: 258),
            .init(weekday: .sat, usageMinutes: 125),
            .init(weekday: .sun, usageMinutes: 94)
        ],
        apps: [UsageApp] = [
            .init(title: "Instagram", usageMinutes: 130),
            .init(title: "YouTube", usageMinutes: 105),
            .init(title: "TikTok", usageMinutes: 75)
        ]
    ) {
        self.summary = summary
        self.weeklyActivityItems = weeklyActivityItems
        self.apps = apps
    }

    func weeklySummary() async throws -> UsageSummary? {
        summary
    }

    func weeklyActivity() async throws -> [UsageDayActivity] {
        weeklyActivityItems
    }

    func topApps() async throws -> [UsageApp] {
        apps
    }
}
