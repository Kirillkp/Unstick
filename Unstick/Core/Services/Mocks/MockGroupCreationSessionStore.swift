//
//  MockGroupCreationSessionStore.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// In-memory сессия создания группы, живущая в рамках AppServices.
actor MockGroupCreationSessionStore: IGroupCreationSessionStore {
    private var selectionPayload: GroupCreationSelectionPayload = .init(selectedAppIDs: [], summary: nil)
    private var currentSettings: RestrictionSettings

    init(defaultSettings: RestrictionSettings = GroupCreationDefaults.settings) {
        self.currentSettings = defaultSettings
    }

    func reset(defaultSettings: RestrictionSettings) async {
        selectionPayload = .init(selectedAppIDs: [], summary: nil)
        currentSettings = defaultSettings
    }

    func selection() async -> GroupCreationSelectionPayload {
        selectionPayload
    }

    func updateSelection(_ selection: GroupCreationSelectionPayload) async {
        selectionPayload = selection
    }

    func settings() async -> RestrictionSettings {
        currentSettings
    }

    func updateSettings(_ settings: RestrictionSettings) async {
        currentSettings = settings
    }
}
