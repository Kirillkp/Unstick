//
//  AppleGroupPolicyService.swift
//  Unstick
//
//  Created by Codex on 15.04.2026.
//

import FamilyControls
import Foundation
import ManagedSettings

/// Реальная реализация применения ограничений через `ManagedSettingsStore`.
actor AppleGroupPolicyService: IGroupPolicyService {
    private let activitySelectionService: IActivitySelectionService
    private var selectionByGroupId: [UUID: FamilyActivitySelection] = [:]

    init(activitySelectionService: IActivitySelectionService) {
        self.activitySelectionService = activitySelectionService
    }

    func applyPolicy(group: RestrictionGroup) async throws {
        let selection = try await resolveSelection(for: group.id)
        let summary = activitySelectionService.selectionSummary(selection)
        guard !summary.isEmpty else {
            throw PolicyApplyError.inconsistentGroup
        }

        selectionByGroupId[group.id] = selection
        let store = makeStore(groupId: group.id)
        apply(selection: selection, to: store)
    }

    func pausePolicy(groupId: UUID) async throws {
        let store = makeStore(groupId: groupId)
        clear(store: store)
    }

    func activatePolicy(groupId: UUID) async throws {
        guard let selection = selectionByGroupId[groupId] else {
            throw PolicyApplyError.inconsistentGroup
        }

        let store = makeStore(groupId: groupId)
        apply(selection: selection, to: store)
    }

    func clearPolicy(groupId: UUID) async throws {
        selectionByGroupId[groupId] = nil
        let store = makeStore(groupId: groupId)
        clear(store: store)
    }
}

private extension AppleGroupPolicyService {
    func resolveSelection(for groupId: UUID) async throws -> FamilyActivitySelection {
        if let cachedSelection = selectionByGroupId[groupId] {
            return cachedSelection
        }

        // В текущем MVP интеграция selection сохраняется in-memory:
        // после перезапуска приложения selection нужно выбрать заново
        // до появления персистентного хранения Apple токенов.
        return try await activitySelectionService.currentSelection()
    }

    func makeStore(groupId: UUID) -> ManagedSettingsStore {
        ManagedSettingsStore(named: .init("group.\(groupId.uuidString)"))
    }

    func apply(selection: FamilyActivitySelection, to store: ManagedSettingsStore) {
        store.shield.applications = selection.applicationTokens
        store.shield.applicationCategories = .specific(selection.categoryTokens)
        store.shield.webDomains = selection.webDomainTokens
    }

    func clear(store: ManagedSettingsStore) {
        store.shield.applications = nil
        store.shield.applicationCategories = nil
        store.shield.webDomains = nil
    }
}
