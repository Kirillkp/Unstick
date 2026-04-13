//
//  AppSelectionCatalogService.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Интерфейс каталога приложений/категорий для экрана AppSelection.
protocol IAppSelectionCatalogService {
    /// Возвращает доступный каталог категорий и приложений.
    func fetchCatalog() async throws -> [AppSelectionCatalogCategory]
}
