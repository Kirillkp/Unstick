//
//  RestrictionSetupOnDemandCardModel.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import Foundation

nonisolated struct RestrictionSetupOnDemandCardModel: BaseCellViewModel, @unchecked Sendable {
    let id: UUID
    let title: String
    let subtitle: String
    let extraTimeTitle: String
    let extraTimeValue: String
    let extraTimeSelectedMinute: Int
    let minuteOptions: [Int]
    let isEnabled: Bool
    let onToggleChanged: ((Bool) -> Void)?
    let onExtraTimeSelected: ((Int) -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        subtitle: String,
        extraTimeTitle: String,
        extraTimeValue: String,
        extraTimeSelectedMinute: Int,
        minuteOptions: [Int],
        isEnabled: Bool,
        onToggleChanged: ((Bool) -> Void)? = nil,
        onExtraTimeSelected: ((Int) -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.extraTimeTitle = extraTimeTitle
        self.extraTimeValue = extraTimeValue
        self.extraTimeSelectedMinute = extraTimeSelectedMinute
        self.minuteOptions = minuteOptions
        self.isEnabled = isEnabled
        self.onToggleChanged = onToggleChanged
        self.onExtraTimeSelected = onExtraTimeSelected
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<RestrictionSetupOnDemandCardView>.self)
    }

    nonisolated static func == (
        lhs: RestrictionSetupOnDemandCardModel,
        rhs: RestrictionSetupOnDemandCardModel
    ) -> Bool {
        lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.extraTimeTitle == rhs.extraTimeTitle
            && lhs.extraTimeValue == rhs.extraTimeValue
            && lhs.extraTimeSelectedMinute == rhs.extraTimeSelectedMinute
            && lhs.minuteOptions == rhs.minuteOptions
            && lhs.isEnabled == rhs.isEnabled
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(extraTimeTitle)
        hasher.combine(extraTimeValue)
        hasher.combine(extraTimeSelectedMinute)
        hasher.combine(minuteOptions)
        hasher.combine(isEnabled)
    }
}
