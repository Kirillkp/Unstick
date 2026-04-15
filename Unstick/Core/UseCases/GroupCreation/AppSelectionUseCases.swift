//
//  AppSelectionUseCases.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation
import FamilyControls

/// Результат загрузки данных для экрана выбора приложений.
enum LoadAppSelectionResult {
    /// Экран готов к отображению с текущим системным selection и его summary.
    case ready(
        selection: FamilyActivitySelection,
        summary: SelectionSummary
    )
}

/// Объединенный контракт use cases экрана AppSelection.
protocol IAppSelectionUseCases {
    /// Загружает текущее состояние выбора приложений/категорий.
    func loadAppSelection() async -> LoadAppSelectionResult
    /// Сохраняет обновленный выбор приложений/категорий.
    func updateSelection(selection: FamilyActivitySelection) async -> Bool
    /// Валидирует выбор перед переходом к RestrictionSetup.
    func confirmSelection(selection: FamilyActivitySelection) throws
}

/// Реализация use cases экрана AppSelection.
final class AppSelectionUseCases: IAppSelectionUseCases {
    private let sessionStore: IGroupCreationSessionStore
    private let activitySelectionService: IActivitySelectionService

    init(
        sessionStore: IGroupCreationSessionStore,
        activitySelectionService: IActivitySelectionService
    ) {
        self.sessionStore = sessionStore
        self.activitySelectionService = activitySelectionService
    }

    func loadAppSelection() async -> LoadAppSelectionResult {
        let selection = (try? await activitySelectionService.currentSelection()) ?? .init()
        let summary = activitySelectionService.selectionSummary(selection)
        await persistSelectionSummary(summary)
        return .ready(selection: selection, summary: summary)
    }

    func updateSelection(selection: FamilyActivitySelection) async -> Bool {
        try? await activitySelectionService.setSelection(selection)
        let summary = activitySelectionService.selectionSummary(selection)
        await persistSelectionSummary(summary)
        return !summary.isEmpty
    }

    func confirmSelection(selection: FamilyActivitySelection) throws {
        let summary = activitySelectionService.selectionSummary(selection)
        guard !summary.isEmpty else {
            throw ValidationError.emptySelection
        }
    }
}

private extension AppSelectionUseCases {
    func persistSelectionSummary(_ summary: SelectionSummary) async {
        let payload = GroupCreationSelectionPayload(
            selectedAppIDs: [],
            summary: summary
        )
        await sessionStore.updateSelection(payload)
    }
}
