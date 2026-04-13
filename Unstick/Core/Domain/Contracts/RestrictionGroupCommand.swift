//
//  RestrictionGroupCommand.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Команды доменного слоя для управления жизненным циклом группы ограничений.
/// Эти команды инициируют изменения состояния через use case-слой.
enum RestrictionGroupCommand: Equatable {
    /// Стартует новую create-group сессию.
    case startGroupCreation
    /// Обновляет выбор приложений/категорий в текущей create-group сессии.
    case updateSelection
    /// Обновляет настройки ограничений (имя, лимит, перерыв, on-demand).
    case updateRestrictionSettings
    /// Запускает транзакцию создания группы и применения policy.
    case createGroup
    /// Переводит группу в состояние паузы.
    /// - Parameter groupId: Идентификатор группы.
    case pauseGroup(groupId: UUID)
    /// Возвращает группу в активное состояние.
    /// - Parameter groupId: Идентификатор группы.
    case resumeGroup(groupId: UUID)
    /// Физически удаляет группу.
    /// - Parameter groupId: Идентификатор группы.
    case deleteGroup(groupId: UUID)
    /// Повторно проверяет текущий статус доступа к системным ограничениям.
    case refreshAuthorization
}
