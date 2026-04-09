// AUTO-GENERATED FILE. DO NOT EDIT.

import Foundation

enum L10n {

    enum Common {
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

                static let note = String(localized: "main.empty.note")

                static let subtitle = String(localized: "main.empty.subtitle")

                static let title = String(localized: "main.empty.title")

        }

        enum Groups {
                static func activeCount(arg0: CVarArg) -> String {
                    String(format: String(localized: "main.groups.activeCount"), arg0)
                }

                static let title = String(localized: "main.groups.title")

        }

    }

    enum Onboarding {
            static let logoTitle = String(localized: "onboarding.logoTitle")

            static let subtitle = String(localized: "onboarding.subtitle")

            static let title = String(localized: "onboarding.title")

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