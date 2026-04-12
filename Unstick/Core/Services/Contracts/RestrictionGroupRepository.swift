//
//  RestrictionGroupRepository.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Интерфейс репозитория групп ограничений.
/// Отвечает за хранение и чтение сущностей RestrictionGroup.
protocol IRestrictionGroupRepository {
    /// Возвращает все сохраненные группы.
    func fetchAll() async throws -> [RestrictionGroup]

    /// Возвращает группу по идентификатору.
    /// - Parameter id: Идентификатор группы.
    func fetch(id: UUID) async throws -> RestrictionGroup?

    /// Создает или обновляет группу в хранилище.
    /// - Parameter group: Сущность группы для сохранения.
    func save(_ group: RestrictionGroup) async throws

    /// Физически удаляет группу по идентификатору.
    /// - Parameter id: Идентификатор группы.
    func delete(id: UUID) async throws

    /// Обновляет только статус группы.
    /// - Parameters:
    ///   - id: Идентификатор группы.
    ///   - status: Новый статус группы.
    func updateStatus(id: UUID, status: RestrictionGroupStatus) async throws
}
