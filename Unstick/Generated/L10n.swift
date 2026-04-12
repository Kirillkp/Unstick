// AUTO-GENERATED FILE. DO NOT EDIT.

import Foundation

enum L10n {

    enum Common {
        enum Duration {
                static func hoursMinutesShortFormat(arg0: CVarArg, arg1: CVarArg) -> String {
                    String(format: String(localized: "common.duration.hoursMinutesShortFormat"), arg0, arg1)
                }

                static func hoursShortFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "common.duration.hoursShortFormat"), arg0)
                }

                static func minutesShortFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "common.duration.minutesShortFormat"), arg0)
                }

        }

            static let next = String(localized: "common.Next")

    }

    enum Indicator {
        enum Empty {
                static let today = String(localized: "indicator.empty.today")

                static let todayNotStarted = String(localized: "indicator.empty.todayNotStarted")

        }

        enum Fill {
                static let goodBalance = String(localized: "indicator.fill.goodBalance")

                static let today = String(localized: "indicator.fill.today")

        }

    }

    enum Main {
        enum Action {
                static let newGroup = String(localized: "main.action.newGroup")

        }

        enum Empty {
                static let actionTitle = String(localized: "main.empty.actionTitle")

                static let subtitle = String(localized: "main.empty.subtitle")

                static let title = String(localized: "main.empty.title")

        }

        enum Groups {
                static func activeCount(arg0: CVarArg) -> String {
                    String(format: String(localized: "main.groups.activeCount"), arg0)
                }

                static let title = String(localized: "main.groups.title")

        }

        enum Indicator {
                static let zeroPercent = String(localized: "main.indicator.zeroPercent")

        }

        enum NoAccess {
                static let actionTitle = String(localized: "main.noAccess.actionTitle")

                static let indicatorTitle = String(localized: "main.noAccess.indicatorTitle")

                static let subtitle = String(localized: "main.noAccess.subtitle")

                static let title = String(localized: "main.noAccess.title")

        }

        enum Usage {
                static let configurationError = String(localized: "main.usage.configurationError")

                static func limitExceededFormat(arg0: CVarArg, arg1: CVarArg) -> String {
                    String(format: String(localized: "main.usage.limitExceededFormat"), arg0, arg1)
                }

                static let paused = String(localized: "main.usage.paused")

                static func progressFormat(arg0: CVarArg, arg1: CVarArg) -> String {
                    String(format: String(localized: "main.usage.progressFormat"), arg0, arg1)
                }

        }

    }

    enum Onboarding {
            static let logoTitle = String(localized: "onboarding.logoTitle")

            static let subtitle = String(localized: "onboarding.subtitle")

            static let title = String(localized: "onboarding.title")

    }

    enum Settings {
        enum About {
                static let privacyPolicy = String(localized: "settings.about.privacyPolicy")

                static let rateInAppStore = String(localized: "settings.about.rateInAppStore")

                static let termsOfUse = String(localized: "settings.about.termsOfUse")

                static let title = String(localized: "settings.about.title")

                static let version = String(localized: "settings.about.version")

                static let versionValue = String(localized: "settings.about.versionValue")

                static let whatsNew = String(localized: "settings.about.whatsNew")

        }

        enum General {
                static let deferredResume = String(localized: "settings.general.deferredResume")

                static let deferredResumeValue = String(localized: "settings.general.deferredResumeValue")

                static let notifications = String(localized: "settings.general.notifications")

                static let strictMode = String(localized: "settings.general.strictMode")

                static let title = String(localized: "settings.general.title")

        }

        enum Personalization {
                static let appearance = String(localized: "settings.personalization.appearance")

                static let hapticsAndSound = String(localized: "settings.personalization.hapticsAndSound")

                static let interventionTone = String(localized: "settings.personalization.interventionTone")

                static let title = String(localized: "settings.personalization.title")

        }

        enum Protection {
                static let disableProtection = String(localized: "settings.protection.disableProtection")

                static let passcode = String(localized: "settings.protection.passcode")

                static let passcodeValue = String(localized: "settings.protection.passcodeValue")

                static let title = String(localized: "settings.protection.title")

        }

        enum Support {
                static let faq = String(localized: "settings.support.faq")

                static let feedback = String(localized: "settings.support.feedback")

                static let introduction = String(localized: "settings.support.introduction")

                static let title = String(localized: "settings.support.title")

        }

            static let title = String(localized: "settings.title")

    }

    enum Statistics {
        enum Activity {
                static let fri = String(localized: "statistics.activity.fri")

                static let mon = String(localized: "statistics.activity.mon")

                static let sat = String(localized: "statistics.activity.sat")

                static let subtitle = String(localized: "statistics.activity.subtitle")

                static let sun = String(localized: "statistics.activity.sun")

                static let thu = String(localized: "statistics.activity.thu")

                static let title = String(localized: "statistics.activity.title")

                static let tue = String(localized: "statistics.activity.tue")

                static let wed = String(localized: "statistics.activity.wed")

        }

        enum Metrics {
                static let canceledTitle = String(localized: "statistics.metrics.canceledTitle")

                static let focusScoreTitle = String(localized: "statistics.metrics.focusScoreTitle")

                static let savedTitle = String(localized: "statistics.metrics.savedTitle")

                static let streakTitle = String(localized: "statistics.metrics.streakTitle")

        }

    }
}