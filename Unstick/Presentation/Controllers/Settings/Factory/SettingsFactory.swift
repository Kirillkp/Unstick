//
//  SettingsFactory.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import Foundation
import UIKit

final class SettingsFactory: SettingsFactoryProtocol {
    func makeFilledState() -> SettingsViewState.Filled {
        .init(
            sections: [
                .init(
                    id: SettingsCollectionSection.general.sectionIdentifier,
                    title: L10n.Settings.General.title,
                    rows: [
                        .init(
                            title: L10n.Settings.General.notifications,
                            iconSystemName: "bell.badge.fill",
                            iconStyle: .indigo,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.General.deferredResume,
                            iconSystemName: "clock.arrow.trianglehead.counterclockwise.rotate.90",
                            iconStyle: .violet,
                            accessory: .valueWithChevron(L10n.Settings.General.deferredResumeValue)
                        ),
                        .init(
                            title: L10n.Settings.General.strictMode,
                            iconSystemName: "lock.shield.fill",
                            iconStyle: .red,
                            accessory: .toggle(isOn: false)
                        )
                    ]
                ),
                .init(
                    id: SettingsCollectionSection.protection.sectionIdentifier,
                    title: L10n.Settings.Protection.title,
                    rows: [
                        .init(
                            title: L10n.Settings.Protection.passcode,
                            iconSystemName: "ellipsis.rectangle.fill",
                            iconStyle: .violet,
                            accessory: .valueWithChevron(L10n.Settings.Protection.passcodeValue)
                        ),
                        .init(
                            title: L10n.Settings.Protection.disableProtection,
                            iconSystemName: "shield.lefthalf.filled",
                            iconStyle: .cyan,
                            accessory: .chevron
                        )
                    ]
                ),
                .init(
                    id: SettingsCollectionSection.personalization.sectionIdentifier,
                    title: L10n.Settings.Personalization.title,
                    rows: [
                        .init(
                            title: L10n.Settings.Personalization.appearance,
                            iconSystemName: "paintpalette.fill",
                            iconStyle: .orange,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.Personalization.hapticsAndSound,
                            iconSystemName: "waveform.circle.fill",
                            iconStyle: .magenta,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.Personalization.interventionTone,
                            iconSystemName: "brain.head.profile",
                            iconStyle: .green,
                            accessory: .chevron
                        )
                    ]
                ),
                .init(
                    id: SettingsCollectionSection.support.sectionIdentifier,
                    title: L10n.Settings.Support.title,
                    rows: [
                        .init(
                            title: L10n.Settings.Support.introduction,
                            iconSystemName: "questionmark.circle.fill",
                            iconStyle: .yellow,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.Support.faq,
                            iconSystemName: "text.bubble.fill",
                            iconStyle: .mint,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.Support.feedback,
                            iconSystemName: "message.fill",
                            iconStyle: .teal,
                            accessory: .chevron
                        )
                    ]
                ),
                .init(
                    id: SettingsCollectionSection.about.sectionIdentifier,
                    title: L10n.Settings.About.title,
                    rows: [
                        .init(
                            title: L10n.Settings.About.whatsNew,
                            iconSystemName: "sparkles",
                            iconStyle: .blue,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.About.rateInAppStore,
                            iconSystemName: "star.fill",
                            iconStyle: .pink,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.About.privacyPolicy,
                            iconSystemName: "hand.raised.fill",
                            iconStyle: .gray,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.About.termsOfUse,
                            iconSystemName: "doc.text.fill",
                            iconStyle: .gray,
                            accessory: .chevron
                        ),
                        .init(
                            title: L10n.Settings.About.version,
                            iconSystemName: "info.circle.fill",
                            iconStyle: .gray,
                            accessory: .value(L10n.Settings.About.versionValue)
                        )
                    ]
                )
            ]
        )
    }

    func makeCollectionContent(for state: SettingsViewState.Filled) -> [AnyCollectionSection] {
        state.sections.enumerated().compactMap { index, section in
            guard let collectionSection = SettingsCollectionSection(rawValue: index) else {
                return nil
            }

            return AnyCollectionSection(
                id: collectionSection,
                identifier: collectionSection.sectionIdentifier,
                supplementaryItem: AnyCollectionSupplementaryItem(
                    SettingsSectionHeaderModel(title: section.title)
                ),
                items: [
                    AnyCollectionItem(section)
                ]
            )
        }
    }
}
