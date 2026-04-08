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
}