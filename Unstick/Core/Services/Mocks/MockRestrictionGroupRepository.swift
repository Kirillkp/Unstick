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

    init(groups: [RestrictionGroup] = MockRestrictionGroupRepository.defaultSeedGroups()) {
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

private extension MockRestrictionGroupRepository {
    static func defaultSeedGroups() -> [RestrictionGroup] {
        let settings: [RestrictionSettings] = [
            .init(
                groupName: "Соцсети",
                dailyLimitMinutes: 120,
                breakSettings: .init(isEnabled: true, remindEveryMinutes: 20, durationMinutes: 5),
                onDemandSettings: .init(isEnabled: true, extraMinutes: 10)
            ),
            .init(
                groupName: "Видео",
                dailyLimitMinutes: 60,
                breakSettings: .init(isEnabled: true, remindEveryMinutes: 15, durationMinutes: 5),
                onDemandSettings: .init(isEnabled: true, extraMinutes: 10)
            ),
            .init(
                groupName: "Игры",
                dailyLimitMinutes: 30,
                breakSettings: .init(isEnabled: false, remindEveryMinutes: 20, durationMinutes: 5),
                onDemandSettings: .init(isEnabled: true, extraMinutes: 5)
            ),
            .init(
                groupName: "Новости",
                dailyLimitMinutes: 90,
                breakSettings: .init(isEnabled: true, remindEveryMinutes: 25, durationMinutes: 5),
                onDemandSettings: .init(isEnabled: true, extraMinutes: 10)
            ),
            .init(
                groupName: "Мессенджеры",
                dailyLimitMinutes: 45,
                breakSettings: .init(isEnabled: true, remindEveryMinutes: 15, durationMinutes: 5),
                onDemandSettings: .init(isEnabled: true, extraMinutes: 10)
            ),
            .init(
                groupName: "Стриминг",
                dailyLimitMinutes: 50,
                breakSettings: .init(isEnabled: true, remindEveryMinutes: 20, durationMinutes: 10),
                onDemandSettings: .init(isEnabled: true, extraMinutes: 10)
            )
        ]

        return [
            .init(selectionData: Data(), settings: settings[0], usedMinutesToday: 35, status: .active),   // < 50% -> primary
            .init(selectionData: Data(), settings: settings[1], usedMinutesToday: 40, status: .active),   // 50...90% -> warning
            .init(selectionData: Data(), settings: settings[2], usedMinutesToday: 28, status: .active),   // >= 90% -> danger
            .init(selectionData: Data(), settings: settings[3], usedMinutesToday: 20, status: .paused),   // paused
            .init(selectionData: Data(), settings: settings[4], usedMinutesToday: 22, status: .configurationError), // config error
            .init(selectionData: Data(), settings: settings[5], usedMinutesToday: 65, status: .active)    // exceeded -> danger
        ]
    }
    
    static func emptySeedGroups() -> [RestrictionGroup] {
        return []
    }
}
