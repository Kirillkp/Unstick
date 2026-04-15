//
//  RestrictionGroupSeedFactory.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

enum RestrictionGroupSeedFactory {
    static func makeDefaultGroups() -> [RestrictionGroup] {
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
            .init(selectionData: Data(), settings: settings[0], usedMinutesToday: 35, status: .active),
            .init(selectionData: Data(), settings: settings[1], usedMinutesToday: 40, status: .active),
            .init(selectionData: Data(), settings: settings[2], usedMinutesToday: 28, status: .active),
            .init(selectionData: Data(), settings: settings[3], usedMinutesToday: 20, status: .paused),
            .init(selectionData: Data(), settings: settings[4], usedMinutesToday: 22, status: .active),
            .init(selectionData: Data(), settings: settings[5], usedMinutesToday: 65, status: .active)
        ]
    }
}

