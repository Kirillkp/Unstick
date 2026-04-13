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
    /// Возвращает текущий selection в рамках create-group сессии.
    func currentSelection() async throws -> FamilyActivitySelection

    /// Сохраняет selection в рамках create-group сессии.
    /// - Parameter selection: Выбранные приложения/категории/домены.
    func setSelection(_ selection: FamilyActivitySelection) async throws

    /// Формирует агрегированное summary выбора для отображения в UI.
    /// - Parameter selection: Выбранные элементы из системного picker.
    /// - Returns: Краткая сводка количества выбранных сущностей.
    func selectionSummary(_ selection: FamilyActivitySelection) -> SelectionSummary
}
