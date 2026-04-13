//
//  AppSelectionUseCases.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Результат загрузки данных для экрана выбора приложений.
enum LoadAppSelectionResult {
    /// Экран готов к отображению с текущим selection из сессии.
    case ready(
        selection: GroupCreationSelectionPayload,
        catalog: [AppSelectionCatalogCategory]
    )
}

/// Объединенный контракт use cases экрана AppSelection.
protocol IAppSelectionUseCases {
    /// Загружает текущее состояние выбора приложений/категорий.
    func loadAppSelection() async -> LoadAppSelectionResult
    /// Сохраняет обновленный выбор приложений/категорий.
    func updateSelection(selection: GroupCreationSelectionPayload) async -> Bool
    /// Валидирует выбор перед переходом к RestrictionSetup.
    func confirmSelection(selection: GroupCreationSelectionPayload) throws
}

/// Реализация use cases экрана AppSelection.
final class AppSelectionUseCases: IAppSelectionUseCases {
    private let sessionStore: IGroupCreationSessionStore
    private let catalogService: IAppSelectionCatalogService

    init(
        sessionStore: IGroupCreationSessionStore,
        catalogService: IAppSelectionCatalogService
    ) {
        self.sessionStore = sessionStore
        self.catalogService = catalogService
    }

    func loadAppSelection() async -> LoadAppSelectionResult {
        let selection = await sessionStore.selection()
        let catalog = (try? await catalogService.fetchCatalog()) ?? []
        return .ready(selection: selection, catalog: catalog)
    }

    func updateSelection(selection: GroupCreationSelectionPayload) async -> Bool {
        await sessionStore.updateSelection(selection)
        return !selection.isEmpty
    }

    func confirmSelection(selection: GroupCreationSelectionPayload) throws {
        guard !selection.isEmpty else {
            throw ValidationError.emptySelection
        }
    }
}
