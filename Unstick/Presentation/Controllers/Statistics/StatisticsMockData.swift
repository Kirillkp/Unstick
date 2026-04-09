//
//  StatisticsMockData.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import Foundation

enum StatisticsMockData {
    enum Hero {
        static let badge = "ПОБЕДА СЕГОДНЯ"
        static let title = "Сегодня вы\nсохранили 2ч\n24м"
        static let highlightedHours = "2ч"
        static let highlightedMinutes = "24м"
        static let subtitle = "Это на 42% больше сфокусированного времени, чем в среднем за неделю."
    }

    enum Metrics {
        static let savedValue = "14.2 часов"
        static let canceledValue = "128"
        static let streakValue = "12 дней"
        static let focusScoreValue = "88 +"
    }

    enum Activity {
        static let monValueTitle = "1ч 12м"
        static let tueValueTitle = "1ч 46м"
        static let wedValueTitle = "58м"
        static let thuValueTitle = "1ч 34м"
        static let friValueTitle = "2ч 24м"
        static let satValueTitle = "1ч 08м"
        static let sunValueTitle = "42м"
    }

    enum Analysis {
        static let instagramTriggerTitle = "Главный триггер: Instagram"
        static let instagramTriggerSubtitle = "За последние 6 дней"
        static let criticalWindowTitle = "Критическое окно: 20:00"
        static let criticalWindowSubtitle = "Больше всего отказов происходит за один час до вечернего отдыха."
    }
}
