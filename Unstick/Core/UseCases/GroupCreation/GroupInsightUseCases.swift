//
//  GroupInsightUseCases.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

enum GroupInsightActivityItemStyle {
    case primary
    case accent
    case warning
}

struct GroupInsightActivityItem {
    let weekday: UsageWeekday
    let usageMinutes: Int
    let normalizedValue: Double
    let style: GroupInsightActivityItemStyle
}

/// Результат загрузки данных для экрана GroupInsight.
enum LoadGroupInsightResult {
    /// Доступ к ограничениям отсутствует, показываем no-access состояние.
    case noAccess
    /// Доступ есть, возвращаем summary и топ приложений.
    case content(
        summary: UsageSummary?,
        weeklyActivity: [GroupInsightActivityItem],
        topApps: [UsageApp]
    )
}

/// Объединенный контракт use cases экрана GroupInsight.
protocol IGroupInsightUseCases {
    /// Загружает данные GroupInsight с учетом текущего доступа.
    func loadGroupInsight() async -> LoadGroupInsightResult
    /// Стартует create-group сессию перед переходом к AppSelection.
    func continueFromInsight() async throws
}

/// Реализация use cases экрана GroupInsight.
final class GroupInsightUseCases: IGroupInsightUseCases {
    private let authorizationService: IAuthorizationService
    private let usageInsightsService: IUsageInsightsService
    private let sessionStore: IGroupCreationSessionStore

    init(
        authorizationService: IAuthorizationService,
        usageInsightsService: IUsageInsightsService,
        sessionStore: IGroupCreationSessionStore
    ) {
        self.authorizationService = authorizationService
        self.usageInsightsService = usageInsightsService
        self.sessionStore = sessionStore
    }

    func loadGroupInsight() async -> LoadGroupInsightResult {
        let status = await authorizationService.authorizationStatus()
        guard status == .available else { return .noAccess }

        let summary = try? await usageInsightsService.weeklySummary()
        let weeklyActivity = (try? await usageInsightsService.weeklyActivity()) ?? []
        let topApps = (try? await usageInsightsService.topApps()) ?? []
        return .content(
            summary: summary ?? nil,
            weeklyActivity: makeActivityItems(from: weeklyActivity),
            topApps: topApps
        )
    }

    func continueFromInsight() async throws {
        let status = await authorizationService.authorizationStatus()
        guard status == .available else {
            throw AccessError.authorizationMissing
        }

        await sessionStore.reset(defaultSettings: GroupCreationDefaults.settings)
    }

    func makeActivityItems(from days: [UsageDayActivity]) -> [GroupInsightActivityItem] {
        guard !days.isEmpty else { return [] }

        let maxMinutes = max(days.map(\.usageMinutes).max() ?? 1, 1)
        return days.map { day in
            let normalizedValue = min(Double(day.usageMinutes) / Double(maxMinutes), 1.0)
            return GroupInsightActivityItem(
                weekday: day.weekday,
                usageMinutes: day.usageMinutes,
                normalizedValue: normalizedValue,
                style: makeActivityItemStyle(normalizedValue: normalizedValue)
            )
        }
    }

    func makeActivityItemStyle(normalizedValue: Double) -> GroupInsightActivityItemStyle {
        if normalizedValue >= 0.9 {
            return .accent
        }
        if normalizedValue >= 0.5 {
            return .warning
        }
        return .primary
    }
}
