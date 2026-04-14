//
//  DailyLimitCardModel.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

nonisolated struct DailyLimitCardModel: BaseCellViewModel, @unchecked Sendable {
    let id: UUID
    let title: String
    let hours: [Int]
    let minutes: [Int]
    let selectedHour: Int
    let selectedMinute: Int
    let caption: String
    let onHourChanged: ((Int) -> Void)?
    let onMinuteChanged: ((Int) -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        hours: [Int],
        minutes: [Int],
        selectedHour: Int,
        selectedMinute: Int,
        caption: String,
        onHourChanged: ((Int) -> Void)? = nil,
        onMinuteChanged: ((Int) -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.hours = hours
        self.minutes = minutes
        self.selectedHour = selectedHour
        self.selectedMinute = selectedMinute
        self.caption = caption
        self.onHourChanged = onHourChanged
        self.onMinuteChanged = onMinuteChanged
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<DailyLimitCardView>.self)
    }

    nonisolated static func == (
        lhs: DailyLimitCardModel,
        rhs: DailyLimitCardModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.hours == rhs.hours
            && lhs.minutes == rhs.minutes
            && lhs.selectedHour == rhs.selectedHour
            && lhs.selectedMinute == rhs.selectedMinute
            && lhs.caption == rhs.caption
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(hours)
        hasher.combine(minutes)
        hasher.combine(selectedHour)
        hasher.combine(selectedMinute)
        hasher.combine(caption)
    }
}

