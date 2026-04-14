//
//  GroupDetailsFactory.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation
import UIKit

final class GroupDetailsFactory: GroupDetailsFactoryProtocol {
    var onDidTapStatusAction: (() -> Void)?
    var onDidTapDeleteAction: (() -> Void)?

    func makeCollectionContent(
        input: GroupDetailsSectionInput
    ) -> [AnyCollectionSection] {
        let statusModel = makeStatusControlModel(input.statusControl)
        let usageSummaryModel = makeUsageSummaryModel(input.usageSummary)
        let settingsHeaderModel = makeSectionTitleModel("Настройки группы")
        let groupNameModel = makeGroupNameModel(
            value: input.groupName,
            onValueChanged: input.onGroupNameChanged
        )
        let dailyLimitModel = makeDailyLimitModel(input.dailyLimit)
        let breakModel = makeBreakModel(input.breakSettings)
        let onDemandModel = makeOnDemandModel(input.onDemand)
        let appsHeaderModel = makeSectionTitleModel(input.appsTitle)
        let appsListModel = makeAppsListModel(input.appRows)
        let deleteActionModel = makeDeleteActionModel()

        return [
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.statusControl,
                identifier: GroupDetailsCollectionSection.statusControl.sectionIdentifier,
                items: [AnyCollectionItem(statusModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.usageSummary,
                identifier: GroupDetailsCollectionSection.usageSummary.sectionIdentifier,
                items: [AnyCollectionItem(usageSummaryModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.settingsHeader,
                identifier: GroupDetailsCollectionSection.settingsHeader.sectionIdentifier,
                items: [AnyCollectionItem(settingsHeaderModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.groupName,
                identifier: GroupDetailsCollectionSection.groupName.sectionIdentifier,
                items: [AnyCollectionItem(groupNameModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.dailyLimit,
                identifier: GroupDetailsCollectionSection.dailyLimit.sectionIdentifier,
                items: [AnyCollectionItem(dailyLimitModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.breakSettings,
                identifier: GroupDetailsCollectionSection.breakSettings.sectionIdentifier,
                items: [AnyCollectionItem(breakModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.onDemand,
                identifier: GroupDetailsCollectionSection.onDemand.sectionIdentifier,
                items: [AnyCollectionItem(onDemandModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.appsHeader,
                identifier: GroupDetailsCollectionSection.appsHeader.sectionIdentifier,
                items: [AnyCollectionItem(appsHeaderModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.appsList,
                identifier: GroupDetailsCollectionSection.appsList.sectionIdentifier,
                items: [AnyCollectionItem(appsListModel)]
            ),
            AnyCollectionSection(
                id: GroupDetailsCollectionSection.deleteAction,
                identifier: GroupDetailsCollectionSection.deleteAction.sectionIdentifier,
                items: [AnyCollectionItem(deleteActionModel)]
            )
        ]
    }
}

private extension GroupDetailsFactory {
    enum IDs {
        static let statusControl = UUID(uuidString: "A70D6D33-2C2A-4D03-A017-E4A1727A79F8") ?? UUID()
        static let usageSummary = UUID(uuidString: "9F713E35-9BEA-4772-9CB5-8FA6B0D69B95") ?? UUID()
        static let groupName = UUID(uuidString: "6374872B-E9DE-4F00-B278-C75D63A2ACD8") ?? UUID()
        static let dailyLimit = UUID(uuidString: "0B7D3F7E-790C-49C7-ABDA-1FB5AA64467B") ?? UUID()
        static let breakSettings = UUID(uuidString: "56CE9528-6508-4581-A018-E40FE9864D72") ?? UUID()
        static let onDemand = UUID(uuidString: "91D0C6BB-E261-4B37-AEFF-3B554A76123D") ?? UUID()
        static let appsList = UUID(uuidString: "08B6D4D2-7C8E-4FA4-9A1A-4AB512BBF8B0") ?? UUID()
        static let deleteAction = UUID(uuidString: "40CF442A-31D9-4356-9CF2-53DF73F5549A") ?? UUID()
    }

    func makeStatusControlModel(
        _ status: GroupDetailsSectionInput.StatusControl
    ) -> GroupDetailsStatusControlCardModel {
        GroupDetailsStatusControlCardModel(
            id: IDs.statusControl,
            isActive: status.isActive,
            title: status.title,
            subtitle: status.subtitle,
            actionTitle: status.actionTitle,
            onTapAction: onDidTapStatusAction
        )
    }

    func makeUsageSummaryModel(
        _ usage: GroupDetailsSectionInput.UsageSummary
    ) -> GroupDetailsUsageSummaryCardModel {
        GroupDetailsUsageSummaryCardModel(
            id: IDs.usageSummary,
            title: usage.title,
            valueText: formatMinutes(usage.usedMinutes),
            limitText: "из \(formatMinutes(usage.limitMinutes))",
            progress: usage.progress
        )
    }

    func makeSectionTitleModel(_ title: String) -> GroupDetailsSectionTitleModel {
        GroupDetailsSectionTitleModel(title: title)
    }

    func makeGroupNameModel(
        value: String,
        onValueChanged: ((String) -> Void)?
    ) -> GroupNameCardModel {
        GroupNameCardModel(
            id: IDs.groupName,
            title: L10n.RestrictionSetup.GroupName.title,
            value: value,
            placeholder: L10n.RestrictionSetup.GroupName.placeholder,
            onValueChanged: onValueChanged
        )
    }

    func makeDailyLimitModel(_ input: GroupDetailsSectionInput.DailyLimit) -> DailyLimitCardModel {
        DailyLimitCardModel(
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

    func makeBreakModel(_ input: GroupDetailsSectionInput.BreakSettings) -> BreakCardModel {
        BreakCardModel(
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

    func makeOnDemandModel(_ input: GroupDetailsSectionInput.OnDemand) -> OnDemandCardModel {
        OnDemandCardModel(
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

    func makeAppsListModel(
        _ rows: [GroupDetailsSectionInput.AppUsageRow]
    ) -> GroupDetailsAppsListCardModel {
        GroupDetailsAppsListCardModel(
            id: IDs.appsList,
            rows: rows.map {
                .init(
                    id: $0.id,
                    icon: $0.icon,
                    name: $0.name,
                    usageText: $0.usageText
                )
            }
        )
    }

    func makeDeleteActionModel() -> CollectionButtonRowModel {
        CollectionButtonRowModel(
            id: IDs.deleteAction,
            title: "Удалить группу",
            image: UIImage(systemName: "trash"),
            buttonStyle: .custom(
                DS.ButtonConfiguration(
                    backgroundStyle: .clear,
                    borderStyle: .dashed(
                        color: DS.Colors.borderDanger,
                        lineWidth: 2,
                        dashPattern: [6, 6]
                    ),
                    titleColor: DS.Colors.textDanger,
                    titleFont: DS.Font.bold(16),
                    imageSpacing: DS.Spacing.x8,
                    imageSymbolConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium),
                    semanticContentAttribute: .forceLeftToRight
                )
            ),
            onTap: onDidTapDeleteAction
        )
    }

    func formatMinutes(_ minutes: Int) -> String {
        let safeMinutes = max(minutes, 0)
        let hours = safeMinutes / 60
        let restMinutes = safeMinutes % 60

        if hours == 0 {
            return L10n.Common.Duration.minutesShortFormat(arg0: "\(restMinutes)")
        }
        if restMinutes == 0 {
            return L10n.Common.Duration.hoursShortFormat(arg0: "\(hours)")
        }
        return L10n.Common.Duration.hoursMinutesShortFormat(
            arg0: "\(hours)",
            arg1: "\(restMinutes)"
        )
    }
}
