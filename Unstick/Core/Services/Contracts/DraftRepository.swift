//
//  DraftRepository.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Интерфейс репозитория черновика создания группы.
/// Используется для восстановления данных между шагами флоу.
protocol IDraftRepository {
    /// Создает новый черновик с начальными настройками.
    /// - Parameter defaultSettings: Стартовые настройки для черновика.
    /// - Returns: Созданный черновик.
    func startDraft(defaultSettings: RestrictionSettings) async throws -> GroupDraft

    /// Обновляет сохраненный выбор приложений/категорий у черновика.
    /// - Parameters:
    ///   - draftId: Идентификатор черновика.
    ///   - selectionData: Сериализованные данные выбора.
    func updateSelection(draftId: UUID, selectionData: Data?) async throws

    /// Обновляет настройки ограничений у черновика.
    /// - Parameters:
    ///   - draftId: Идентификатор черновика.
    ///   - settings: Новые настройки ограничений.
    func updateSettings(draftId: UUID, settings: RestrictionSettings) async throws

    /// Возвращает текущий активный черновик, если он существует.
    func currentDraft() async throws -> GroupDraft?

    /// Очищает текущий черновик после успешного завершения или отмены флоу.
    func clearDraft() async throws
}
