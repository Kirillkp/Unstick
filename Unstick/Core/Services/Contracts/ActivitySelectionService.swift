//
//  ActivitySelectionService.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import FamilyControls
import Foundation

/// Интерфейс сервиса работы с выбором приложений/категорий через системный picker.
protocol IActivitySelectionService {
    /// Возвращает текущий selection для указанного черновика.
    /// - Parameter draftId: Идентификатор черновика создания группы.
    func currentSelection(draftId: UUID) async throws -> FamilyActivitySelection

    /// Сохраняет selection для указанного черновика.
    /// - Parameters:
    ///   - selection: Выбранные приложения/категории/домены.
    ///   - draftId: Идентификатор черновика.
    func setSelection(_ selection: FamilyActivitySelection, draftId: UUID) async throws

    /// Формирует агрегированное summary выбора для отображения в UI.
    /// - Parameter selection: Выбранные элементы из системного picker.
    /// - Returns: Краткая сводка количества выбранных сущностей.
    func selectionSummary(_ selection: FamilyActivitySelection) -> SelectionSummary
}
