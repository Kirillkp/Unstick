//
//  AppSelectionCatalog.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

struct AppSelectionCatalogApp: Codable, Equatable, Identifiable {
    let id: UUID
    var title: String
    var iconSystemName: String

    init(
        id: UUID = UUID(),
        title: String,
        iconSystemName: String
    ) {
        self.id = id
        self.title = title
        self.iconSystemName = iconSystemName
    }
}

struct AppSelectionCatalogCategory: Codable, Equatable, Identifiable {
    let id: UUID
    var title: String
    var iconSystemName: String
    var apps: [AppSelectionCatalogApp]

    init(
        id: UUID = UUID(),
        title: String,
        iconSystemName: String,
        apps: [AppSelectionCatalogApp]
    ) {
        self.id = id
        self.title = title
        self.iconSystemName = iconSystemName
        self.apps = apps
    }
}
