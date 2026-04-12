//
//  RestrictionGroupEvent.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// События доменного слоя, которые фиксируют факты изменения доступа,
/// черновика и состояния группы ограничений.
enum RestrictionGroupEvent: Equatable {
    /// Результат проверки текущего статуса доступа.
    /// - Parameter status: Текущий статус доступа.
    case authorizationChecked(status: AuthorizationStatus)
    /// Фиксирует, что доступ к системным ограничениям есть.
    case authorizationAvailable
    /// Фиксирует, что доступ к системным ограничениям отсутствует.
    case authorizationMissing
    /// Фиксирует старт создания черновика группы.
    case groupDraftStarted
    /// Фиксирует обновление выбора приложений/категорий.
    case selectionUpdated
    /// Фиксирует обновление настроек ограничений.
    case restrictionSettingsUpdated
    /// Фиксирует намерение создать группу и применить policy.
    case groupCreateRequested
    /// Фиксирует успешное создание группы в хранилище.
    /// - Parameter groupId: Идентификатор созданной группы.
    case groupCreated(groupId: UUID)
    /// Фиксирует успешное применение policy для группы.
    /// - Parameter groupId: Идентификатор группы.
    case policyApplied(groupId: UUID)
    /// Фиксирует ошибку применения policy.
    /// - Parameters:
    ///   - groupId: Идентификатор группы.
    ///   - reason: Причина ошибки применения.
    case policyApplyFailed(groupId: UUID, reason: PolicyApplyError)
    /// Фиксирует перевод группы в состояние паузы.
    /// - Parameter groupId: Идентификатор группы.
    case groupPaused(groupId: UUID)
    /// Фиксирует перевод группы в активное состояние.
    /// - Parameter groupId: Идентификатор группы.
    case groupActive(groupId: UUID)
    /// Фиксирует повторный запрос на применение policy.
    /// - Parameter groupId: Идентификатор группы.
    case groupRetryApplyRequested(groupId: UUID)
    /// Фиксирует физическое удаление группы.
    /// - Parameter groupId: Идентификатор удаленной группы.
    case groupDeleted(groupId: UUID)
}
