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

    /// Возвращает список наиболее используемых приложений.
    /// - Parameter limit: Максимальное количество приложений в выдаче.
    /// - Returns: Отсортированный список по времени использования.
    func topApps(limit: Int) async throws -> [UsageApp]
}
