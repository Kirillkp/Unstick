//
//  GroupPolicyService.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Интерфейс сервиса управления применением ограничений группы.
protocol IGroupPolicyService {
    /// Применяет политику ограничений для группы.
    /// - Parameter group: Группа с настройками и selection для применения.
    func applyPolicy(group: RestrictionGroup) async throws

    /// Временно приостанавливает действие ограничений для группы.
    /// - Parameter groupId: Идентификатор группы.
    func pausePolicy(groupId: UUID) async throws

    /// Повторно активирует ограничения группы после паузы.
    /// - Parameter groupId: Идентификатор группы.
    func activatePolicy(groupId: UUID) async throws

    /// Полностью снимает примененные ограничения группы.
    /// - Parameter groupId: Идентификатор группы.
    func clearPolicy(groupId: UUID) async throws
}
