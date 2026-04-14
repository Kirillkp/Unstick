//
//  GroupDetailsSectionInput.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit

struct GroupDetailsSectionInput {
    struct StatusControl: Sendable {
        let isActive: Bool
        let title: String
        let subtitle: String
        let actionTitle: String
    }

    struct UsageSummary: Sendable {
        let title: String
        let usedMinutes: Int
        let limitMinutes: Int
        let progress: CGFloat
    }

    struct DailyLimit: Sendable {
        let hours: [Int]
        let minutes: [Int]
        let selectedHour: Int
        let selectedMinute: Int
        let onHourChanged: ((Int) -> Void)?
        let onMinuteChanged: ((Int) -> Void)?
    }

    struct BreakSettings: Sendable {
        let isEnabled: Bool
        let reminderMinutes: Int
        let durationMinutes: Int
        let minuteOptions: [Int]
        let onEnabledChanged: ((Bool) -> Void)?
        let onReminderSelected: ((Int) -> Void)?
        let onDurationSelected: ((Int) -> Void)?
    }

    struct OnDemand: Sendable {
        let isEnabled: Bool
        let extraMinutes: Int
        let minuteOptions: [Int]
        let onEnabledChanged: ((Bool) -> Void)?
        let onExtraTimeSelected: ((Int) -> Void)?
    }

    struct AppUsageRow: Sendable {
        let id: UUID
        let icon: UIImage?
        let name: String
        let usageText: String
    }

    struct UpdateAction: Sendable {
        let title: String
        let isEnabled: Bool
    }

    let statusControl: StatusControl
    let usageSummary: UsageSummary
    let groupName: String
    let onGroupNameChanged: ((String) -> Void)?
    let dailyLimit: DailyLimit
    let breakSettings: BreakSettings
    let onDemand: OnDemand
    let appsTitle: String
    let appRows: [AppUsageRow]
    let updateAction: UpdateAction
}
