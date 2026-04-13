//
//  RestrictionSetupSectionInput.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

struct RestrictionSetupSectionInput {
    let groupName: GroupNameInput
    let dailyLimit: DailyLimitInput
    let breakSettings: BreakSettingsInput
    let onDemand: OnDemandInput
}

struct GroupNameInput {
    let value: String
    let onValueChanged: (String) -> Void
}

struct DailyLimitInput {
    let hours: [Int]
    let minutes: [Int]
    let selectedHour: Int
    let selectedMinute: Int
    let onHourChanged: (Int) -> Void
    let onMinuteChanged: (Int) -> Void
}

struct BreakSettingsInput {
    let isEnabled: Bool
    let reminderMinutes: Int
    let durationMinutes: Int
    let minuteOptions: [Int]
    let onEnabledChanged: (Bool) -> Void
    let onReminderSelected: (Int) -> Void
    let onDurationSelected: (Int) -> Void
}

struct OnDemandInput {
    let isEnabled: Bool
    let extraMinutes: Int
    let minuteOptions: [Int]
    let onEnabledChanged: (Bool) -> Void
    let onExtraTimeSelected: (Int) -> Void
}
