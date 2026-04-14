//
//  BreakCardModel.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

nonisolated struct BreakCardModel: BaseCellViewModel, @unchecked Sendable {
    let id: UUID
    let title: String
    let subtitle: String
    let isEnabled: Bool
    let remindEveryTitle: String
    let remindEveryValue: String
    let remindEverySelectedMinute: Int
    let durationTitle: String
    let durationValue: String
    let durationSelectedMinute: Int
    let minuteOptions: [Int]
    let onEnabledChanged: ((Bool) -> Void)?
    let onRemindEverySelected: ((Int) -> Void)?
    let onDurationSelected: ((Int) -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        isEnabled: Bool,
        remindEveryTitle: String,
        remindEveryValue: String,
        remindEverySelectedMinute: Int,
        durationTitle: String,
        durationValue: String,
        durationSelectedMinute: Int,
        minuteOptions: [Int],
        onEnabledChanged: ((Bool) -> Void)? = nil,
        onRemindEverySelected: ((Int) -> Void)? = nil,
        onDurationSelected: ((Int) -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.isEnabled = isEnabled
        self.remindEveryTitle = remindEveryTitle
        self.remindEveryValue = remindEveryValue
        self.remindEverySelectedMinute = remindEverySelectedMinute
        self.durationTitle = durationTitle
        self.durationValue = durationValue
        self.durationSelectedMinute = durationSelectedMinute
        self.minuteOptions = minuteOptions
        self.onEnabledChanged = onEnabledChanged
        self.onRemindEverySelected = onRemindEverySelected
        self.onDurationSelected = onDurationSelected
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<BreakCardView>.self)
    }

    nonisolated static func == (
        lhs: BreakCardModel,
        rhs: BreakCardModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.isEnabled == rhs.isEnabled
            && lhs.remindEveryTitle == rhs.remindEveryTitle
            && lhs.remindEveryValue == rhs.remindEveryValue
            && lhs.remindEverySelectedMinute == rhs.remindEverySelectedMinute
            && lhs.durationTitle == rhs.durationTitle
            && lhs.durationValue == rhs.durationValue
            && lhs.durationSelectedMinute == rhs.durationSelectedMinute
            && lhs.minuteOptions == rhs.minuteOptions
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(isEnabled)
        hasher.combine(remindEveryTitle)
        hasher.combine(remindEveryValue)
        hasher.combine(remindEverySelectedMinute)
        hasher.combine(durationTitle)
        hasher.combine(durationValue)
        hasher.combine(durationSelectedMinute)
        hasher.combine(minuteOptions)
    }
}

