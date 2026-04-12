//
//  DomainErrors.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Ошибки применения политики ограничений для группы.
enum PolicyApplyError: Error, Equatable {
    /// Доступ к системным ограничениям отсутствует, поэтому policy нельзя применить.
    case authorizationMissing
    /// Состояние группы неконсистентно для операции применения policy.
    case inconsistentGroup
    /// Системная операция применения policy завершилась неуспешно.
    case applyFailed
}

/// Ошибки валидации пользовательского ввода и доменных инвариантов.
enum ValidationError: Error, Equatable {
    /// Название группы пустое.
    case groupNameEmpty
    /// Дневной лимит некорректный (например, меньше или равен нулю).
    case invalidDailyLimit
    /// Дополнительное время для on-demand режима некорректно.
    case invalidOnDemandExtraTime
    /// Выбор приложений/категорий пустой.
    case emptySelection
}

/// Ошибки операций хранения и извлечения данных.
enum StorageError: Error, Equatable {
    /// Ошибка сохранения данных.
    case saveFailed
    /// Ошибка чтения данных.
    case fetchFailed
    /// Ошибка удаления данных.
    case deleteFailed
}

/// Ошибки, связанные с доступом к системным возможностям.
enum AccessError: Error, Equatable {
    /// Доступ к необходимым системным возможностям отсутствует.
    case authorizationMissing
}
