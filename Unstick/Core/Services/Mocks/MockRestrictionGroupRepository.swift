//
//  MockRestrictionGroupRepository.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// In-memory mock репозиторий групп ограничений.
actor MockRestrictionGroupRepository: IRestrictionGroupRepository {
    private var groups: [RestrictionGroup]

    init(groups: [RestrictionGroup] = RestrictionGroupSeedFactory.makeDefaultGroups()) {
        self.groups = groups
    }

    func fetchAll() async throws -> [RestrictionGroup] {
        groups.sorted { $0.updatedAt > $1.updatedAt }
    }

    func fetch(id: UUID) async throws -> RestrictionGroup? {
        groups.first { $0.id == id }
    }

    func save(_ group: RestrictionGroup) async throws {
        if let index = groups.firstIndex(where: { $0.id == group.id }) {
            groups[index] = group
        } else {
            groups.append(group)
        }
    }

    func delete(id: UUID) async throws {
        groups.removeAll { $0.id == id }
    }

    func updateStatus(id: UUID, status: RestrictionGroupStatus) async throws {
        guard let index = groups.firstIndex(where: { $0.id == id }) else { return }
        groups[index].status = status
        groups[index].updatedAt = Date()
    }
}
