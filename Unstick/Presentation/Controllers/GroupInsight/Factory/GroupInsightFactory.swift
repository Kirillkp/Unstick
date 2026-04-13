//
//  GroupInsightFactory.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation
import UIKit

final class GroupInsightFactory: GroupInsightFactoryProtocol {
    var onDidTapPrimaryAction: (() -> Void)?

    func makeCollectionContent(
        activityItems: [GroupInsightActivityItem],
        topApps: [UsageApp]
    ) -> [AnyCollectionSection] {
        let hero = makeHeroModel()
        let primaryActionTitle = makePrimaryActionTitle()
        let topAppsHeader = makeTopAppsHeaderModel()
        let activity = makeWeeklyActivityModel(from: activityItems)
        let topAppsModels = makeTopAppsModels(from: topApps)

        return [
            AnyCollectionSection(
                id: GroupInsightCollectionSection.hero,
                identifier: GroupInsightCollectionSection.hero.sectionIdentifier,
                items: [AnyCollectionItem(hero)]
            ),
            AnyCollectionSection(
                id: GroupInsightCollectionSection.primaryAction,
                identifier: GroupInsightCollectionSection.primaryAction.sectionIdentifier,
                items: [
                    AnyCollectionItem(
                        CollectionButtonRowModel(
                            title: primaryActionTitle,
                            buttonStyle: .primary,
                            buttonSize: .xl,
                            onTap: onDidTapPrimaryAction
                        )
                    )
                ]
            ),
            AnyCollectionSection(
                id: GroupInsightCollectionSection.activity,
                identifier: GroupInsightCollectionSection.activity.sectionIdentifier,
                items: [AnyCollectionItem(activity)]
            ),
            AnyCollectionSection(
                id: GroupInsightCollectionSection.topApps,
                identifier: GroupInsightCollectionSection.topApps.sectionIdentifier,
                supplementaryItem: AnyCollectionSupplementaryItem(topAppsHeader),
                items: topAppsModels.map { AnyCollectionItem($0) }
            )
        ]
    }
}

private extension GroupInsightFactory {
    func makeWeeklyActivityModel(from items: [GroupInsightActivityItem]) -> WeeklyActivityCardModel {
        WeeklyActivityCardModel(
            title: L10n.GroupInsight.WeeklyActivity.title,
            subtitle: L10n.GroupInsight.WeeklyActivity.subtitle,
            items: items.map { item in
                .init(
                    dayTitle: dayTitle(for: item.weekday),
                    valueTitle: formatActivityMinutes(item.usageMinutes),
                    value: CGFloat(item.normalizedValue),
                    style: dayStyle(for: item.style)
                )
            }
        )
    }

    func makeTopAppsModels(from apps: [UsageApp]) -> [UsageSummaryCardModel] {
        guard !apps.isEmpty else {
            return [
                .init(
                    title: L10n.GroupInsight.TopApps.emptyTitle,
                    subtitle: L10n.GroupInsight.TopApps.emptySubtitle,
                    progress: 0,
                    style: .primary,
                    appIcons: [.init(image: UIImage(systemName: "clock"))]
                )
            ]
        }

        let maxUsageMinutes = max(apps.map(\.usageMinutes).max() ?? 1, 1)
        return apps.enumerated().map { index, app in
            let progress = CGFloat(min(Double(app.usageMinutes) / Double(maxUsageMinutes), 1))
            let style: UsageSummaryCardModel.Style = {
                switch index {
                case 0: return .danger
                case 1: return .warning
                default: return .primary
                }
            }()

            return .init(
                title: app.title,
                subtitle: L10n.GroupInsight.TopApps.usageMinutesFormat(arg0: app.usageMinutes),
                progress: progress,
                style: style,
                appIcons: [.init(image: UIImage(systemName: "square.stack.3d.up.fill"))]
            )
        }
    }

    func dayTitle(for weekday: UsageWeekday) -> String {
        switch weekday {
        case .mon: return L10n.Statistics.Activity.mon
        case .tue: return L10n.Statistics.Activity.tue
        case .wed: return L10n.Statistics.Activity.wed
        case .thu: return L10n.Statistics.Activity.thu
        case .fri: return L10n.Statistics.Activity.fri
        case .sat: return L10n.Statistics.Activity.sat
        case .sun: return L10n.Statistics.Activity.sun
        }
    }

    func dayStyle(for style: GroupInsightActivityItemStyle) -> WeeklyActivityCardModel.DayActivity.Style {
        switch style {
        case .primary: return .primary
        case .accent: return .accent
        case .warning: return .warning
        }
    }

    func formatActivityMinutes(_ minutes: Int) -> String {
        let safeMinutes = max(minutes, 0)
        let hours = safeMinutes / 60
        let restMinutes = safeMinutes % 60

        if hours == 0 {
            return L10n.GroupInsight.Activity.minutesFormat(arg0: restMinutes)
        }
        if restMinutes == 0 {
            return L10n.GroupInsight.Activity.hoursFormat(arg0: hours)
        }
        return L10n.GroupInsight.Activity.hoursMinutesFormat(arg0: hours, arg1: restMinutes)
    }

    func makeHeroModel() -> HeroSectionModel {
        HeroSectionModel(
            title: L10n.GroupInsight.Hero.title,
            subtitle: L10n.GroupInsight.Hero.subtitle
        )
    }

    func makePrimaryActionTitle() -> String {
        L10n.GroupInsight.Action.selectApps
    }

    func makeTopAppsHeaderModel() -> MainGroupsSectionHeaderModel {
        .init(
            title: L10n.GroupInsight.TopApps.title,
            subtitle: L10n.GroupInsight.TopApps.subtitle
        )
    }
}
