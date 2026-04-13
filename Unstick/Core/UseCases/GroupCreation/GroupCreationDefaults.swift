//
//  GroupCreationDefaults.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Базовые значения для старта новой create-group сессии.
enum GroupCreationDefaults {
    /// Дефолтные настройки ограничений для нового потока создания группы.
    static let settings = RestrictionSettings(
        groupName: "Новая группа",
        dailyLimitMinutes: 60,
        breakSettings: .init(
            isEnabled: true,
            remindEveryMinutes: 45,
            durationMinutes: 5
        ),
        onDemandSettings: .init(
            isEnabled: true,
            extraMinutes: 15
        )
    )
}
