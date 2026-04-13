//
//  RestrictionSetupFactory.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import Foundation

final class RestrictionSetupFactory: RestrictionSetupFactoryProtocol {
    func makeCollectionContent(
        input: RestrictionSetupSectionInput
    ) -> [AnyCollectionSection] {
        let hero = makeHeroModel()
        let groupName = makeGroupNameModel(input.groupName)
        let dailyLimit = makeDailyLimitModel(input.dailyLimit)
        let breakSettings = makeBreakSettingsModel(input.breakSettings)
        let onDemand = makeOnDemandModel(input.onDemand)

        return [
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.hero,
                identifier: RestrictionSetupCollectionSection.hero.sectionIdentifier,
                items: [AnyCollectionItem(hero)]
            ),
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.groupName,
                identifier: RestrictionSetupCollectionSection.groupName.sectionIdentifier,
                items: [AnyCollectionItem(groupName)]
            ),
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.dailyLimit,
                identifier: RestrictionSetupCollectionSection.dailyLimit.sectionIdentifier,
                items: [AnyCollectionItem(dailyLimit)]
            ),
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.breakSettings,
                identifier: RestrictionSetupCollectionSection.breakSettings.sectionIdentifier,
                items: [AnyCollectionItem(breakSettings)]
            ),
            AnyCollectionSection(
                id: RestrictionSetupCollectionSection.onDemand,
                identifier: RestrictionSetupCollectionSection.onDemand.sectionIdentifier,
                items: [AnyCollectionItem(onDemand)]
            )
        ]
    }
}

private extension RestrictionSetupFactory {
    enum IDs {
        static let groupName = UUID(uuidString: "B4B9A39B-E3F4-4266-B4E7-A6F54549F0FC") ?? UUID()
        static let dailyLimit = UUID(uuidString: "5A72B4E3-14BD-4764-9BA5-CE8606A59645") ?? UUID()
        static let breakSettings = UUID(uuidString: "56CE9528-6508-4581-A018-E40FE9864D72") ?? UUID()
        static let onDemand = UUID(uuidString: "91D0C6BB-E261-4B37-AEFF-3B554A76123D") ?? UUID()
    }

    func makeHeroModel() -> HeroSectionModel {
        HeroSectionModel(
            title: L10n.RestrictionSetup.Hero.title,
            subtitle: L10n.RestrictionSetup.Hero.subtitle
        )
    }

    func makeGroupNameModel(_ input: GroupNameInput) -> RestrictionSetupGroupNameCardModel {
        RestrictionSetupGroupNameCardModel(
            id: IDs.groupName,
            title: L10n.RestrictionSetup.GroupName.title,
            value: input.value,
            placeholder: L10n.RestrictionSetup.GroupName.placeholder,
            onValueChanged: input.onValueChanged
        )
    }

    func makeDailyLimitModel(_ input: DailyLimitInput) -> RestrictionSetupDailyLimitCardModel {
        RestrictionSetupDailyLimitCardModel(
            id: IDs.dailyLimit,
            title: L10n.RestrictionSetup.DailyLimit.title,
            hours: input.hours,
            minutes: input.minutes,
            selectedHour: input.selectedHour,
            selectedMinute: input.selectedMinute,
            caption: L10n.RestrictionSetup.DailyLimit.caption,
            onHourChanged: input.onHourChanged,
            onMinuteChanged: input.onMinuteChanged
        )
    }

    func makeBreakSettingsModel(_ input: BreakSettingsInput) -> RestrictionSetupBreakCardModel {
        RestrictionSetupBreakCardModel(
            id: IDs.breakSettings,
            title: L10n.RestrictionSetup.Break.title,
            subtitle: L10n.RestrictionSetup.Break.subtitle,
            isEnabled: input.isEnabled,
            remindEveryTitle: L10n.RestrictionSetup.Break.remindEveryTitle,
            remindEveryValue: L10n.RestrictionSetup.Break.minuteValueFormat(arg0: input.reminderMinutes),
            remindEverySelectedMinute: input.reminderMinutes,
            durationTitle: L10n.RestrictionSetup.Break.durationTitle,
            durationValue: L10n.RestrictionSetup.Break.minuteValueFormat(arg0: input.durationMinutes),
            durationSelectedMinute: input.durationMinutes,
            minuteOptions: input.minuteOptions,
            onEnabledChanged: input.onEnabledChanged,
            onRemindEverySelected: input.onReminderSelected,
            onDurationSelected: input.onDurationSelected
        )
    }

    func makeOnDemandModel(_ input: OnDemandInput) -> RestrictionSetupOnDemandCardModel {
        RestrictionSetupOnDemandCardModel(
            id: IDs.onDemand,
            title: L10n.RestrictionSetup.OnDemand.title,
            subtitle: L10n.RestrictionSetup.OnDemand.subtitle,
            extraTimeTitle: L10n.RestrictionSetup.OnDemand.extraTimeTitle,
            extraTimeValue: L10n.RestrictionSetup.OnDemand.minuteValueFormat(arg0: input.extraMinutes),
            extraTimeSelectedMinute: input.extraMinutes,
            minuteOptions: input.minuteOptions,
            isEnabled: input.isEnabled,
            onToggleChanged: input.onEnabledChanged,
            onExtraTimeSelected: input.onExtraTimeSelected
        )
    }
}
