//
//  GroupCreationSessionStore.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Интерфейс in-memory сессии для простого create-group flow без черновиков.
protocol IGroupCreationSessionStore {
    func reset(defaultSettings: RestrictionSettings) async
    func selection() async -> GroupCreationSelectionPayload
    func updateSelection(_ selection: GroupCreationSelectionPayload) async
    func settings() async -> RestrictionSettings
    func updateSettings(_ settings: RestrictionSettings) async
}
