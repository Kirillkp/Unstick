//
//  LocalRestrictionGroupRepository.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

/// Локальный persistent-репозиторий групп ограничений.
/// Хранит массив RestrictionGroup в UserDefaults через JSON-кодирование.
actor LocalRestrictionGroupRepository: IRestrictionGroupRepository {
    private let userDefaultsService: UserDefaultsServicing
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()

    init(userDefaultsService: UserDefaultsServicing) {
        self.userDefaultsService = userDefaultsService
    }

    func fetchAll() async throws -> [RestrictionGroup] {
        do {
            let groups = try loadGroups()
            return groups.sorted { $0.updatedAt > $1.updatedAt }
        } catch {
            throw StorageError.fetchFailed
        }
    }

    func fetch(id: UUID) async throws -> RestrictionGroup? {
        do {
            let groups = try loadGroups()
            return groups.first { $0.id == id }
        } catch {
            throw StorageError.fetchFailed
        }
    }

    func save(_ group: RestrictionGroup) async throws {
        do {
            var groups = try loadGroups()
            if let index = groups.firstIndex(where: { $0.id == group.id }) {
                groups[index] = group
            } else {
                groups.append(group)
            }
            try persist(groups)
        } catch {
            throw StorageError.saveFailed
        }
    }

    func delete(id: UUID) async throws {
        do {
            var groups = try loadGroups()
            groups.removeAll { $0.id == id }
            try persist(groups)
        } catch {
            throw StorageError.deleteFailed
        }
    }

    func updateStatus(id: UUID, status: RestrictionGroupStatus) async throws {
        do {
            var groups = try loadGroups()
            guard let index = groups.firstIndex(where: { $0.id == id }) else { return }
            groups[index].status = status
            groups[index].updatedAt = Date()
            try persist(groups)
        } catch {
            throw StorageError.saveFailed
        }
    }
}

private extension LocalRestrictionGroupRepository {
    func loadGroups() throws -> [RestrictionGroup] {
        guard let data = userDefaultsService.restrictionGroupsData else {
            return []
        }
        return try decoder.decode([RestrictionGroup].self, from: data)
    }

    func persist(_ groups: [RestrictionGroup]) throws {
        let data = try encoder.encode(groups)
        userDefaultsService.restrictionGroupsData = data
    }
}

