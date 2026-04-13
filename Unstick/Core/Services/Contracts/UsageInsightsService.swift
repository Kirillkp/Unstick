//
//  UsageInsightsService.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Интерфейс сервиса агрегированной статистики использования.
/// Данные используются экраном GroupInsight.
protocol IUsageInsightsService {
    /// Возвращает недельную сводку использования.
    /// - Returns: Сводка или `nil`, если данные недоступны.
    func weeklySummary() async throws -> UsageSummary?

    /// Возвращает активность по дням за последние 7 дней.
    /// - Returns: Список дневной активности.
    func weeklyActivity() async throws -> [UsageDayActivity]

    /// Возвращает полный список используемых приложений.
    /// - Returns: Отсортированный список по времени использования.
    func topApps() async throws -> [UsageApp]
}
