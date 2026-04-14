// AUTO-GENERATED FILE. DO NOT EDIT.

import Foundation

enum L10n {

    enum AppSelection {
        enum Category {
                /// EN: %d selected
                /// RU: %d выбрано
                static func selectedCountFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "appSelection.category.selectedCountFormat"), arg0)
                }

        }

        enum Hero {
                /// EN: Mark the apps that distract you the most from important things.
                /// RU: Отметьте те, которые больше всего отвлекают вас от важных дел.
                static let subtitle = String(localized: "appSelection.hero.subtitle")

                /// EN: Choose\napps
                /// RU: Выберите\nприложения
                static let title = String(localized: "appSelection.hero.title")

        }

    }

    enum Common {
        enum Duration {
                /// EN: %@ h %@ m
                /// RU: %@ч %@м
                static func hoursMinutesShortFormat(arg0: CVarArg, arg1: CVarArg) -> String {
                    String(format: String(localized: "common.duration.hoursMinutesShortFormat"), arg0, arg1)
                }

                /// EN: %@ h
                /// RU: %@ч
                static func hoursShortFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "common.duration.hoursShortFormat"), arg0)
                }

                /// EN: %@ m
                /// RU: %@м
                static func minutesShortFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "common.duration.minutesShortFormat"), arg0)
                }

        }

            /// EN: Continue
            /// RU: Продолжить
            static let next = String(localized: "common.Next")

    }

    enum GroupDetails {
        enum Apps {
                /// EN: Apps in group
                /// RU: Приложения в группе
                static let title = String(localized: "groupDetails.apps.title")

        }

        enum Delete {
                /// EN: Delete group
                /// RU: Удалить группу
                static let actionTitle = String(localized: "groupDetails.delete.actionTitle")

        }

        enum Settings {
                /// EN: Group settings
                /// RU: Настройки группы
                static let title = String(localized: "groupDetails.settings.title")

        }

        enum Status {
                /// EN: Pause group
                /// RU: Приостановить группу
                static let activeAction = String(localized: "groupDetails.status.activeAction")

                /// EN: Restrictions are applied to all apps in this group.
                /// RU: Ограничения применяются ко всем приложениям в этой группе.
                static let activeSubtitle = String(localized: "groupDetails.status.activeSubtitle")

                /// EN: ACTIVE
                /// RU: АКТИВНА
                static let activeTitle = String(localized: "groupDetails.status.activeTitle")

                /// EN: Refresh
                /// RU: Обновить
                static let noDataAction = String(localized: "groupDetails.status.noDataAction")

                /// EN: Group not found.
                /// RU: Группа не найдена.
                static let noDataSubtitle = String(localized: "groupDetails.status.noDataSubtitle")

                /// EN: NO DATA
                /// RU: НЕТ ДАННЫХ
                static let noDataTitle = String(localized: "groupDetails.status.noDataTitle")

                /// EN: Resume group
                /// RU: Возобновить группу
                static let pausedAction = String(localized: "groupDetails.status.pausedAction")

                /// EN: Restrictions are temporarily disabled for apps in this group.
                /// RU: Ограничения временно отключены для приложений этой группы.
                static let pausedSubtitle = String(localized: "groupDetails.status.pausedSubtitle")

                /// EN: PAUSED
                /// RU: НА ПАУЗЕ
                static let pausedTitle = String(localized: "groupDetails.status.pausedTitle")

        }

        enum Update {
                /// EN: Update data
                /// RU: Обновить данные
                static let actionTitle = String(localized: "groupDetails.update.actionTitle")

        }

        enum Usage {
                /// EN: of %@
                /// RU: из %@
                static func limitFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "groupDetails.usage.limitFormat"), arg0)
                }

                /// EN: USED TODAY
                /// RU: ИСПОЛЬЗОВАНО СЕГОДНЯ
                static let title = String(localized: "groupDetails.usage.title")

        }

    }

    enum GroupInsight {
        enum Action {
                /// EN: Select apps
                /// RU: Выберите приложения
                static let selectApps = String(localized: "groupInsight.action.selectApps")

        }

        enum Activity {
                /// EN: %d h
                /// RU: %d ч
                static func hoursFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "groupInsight.activity.hoursFormat"), arg0)
                }

                /// EN: %d h %d min
                /// RU: %d ч %d мин
                static func hoursMinutesFormat(arg0: CVarArg, arg1: CVarArg) -> String {
                    String(format: String(localized: "groupInsight.activity.hoursMinutesFormat"), arg0, arg1)
                }

                /// EN: %d min
                /// RU: %d мин
                static func minutesFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "groupInsight.activity.minutesFormat"), arg0)
                }

        }

        enum Hero {
                /// EN: We analyzed your app usage for the week. This data helps you regain control. Stats for the last 7 days.
                /// RU: Мы проанализировали использование приложений за неделю. Эти данные помогут вам вернуть контроль. Это статистика за последние 7 дней.
                static let subtitle = String(localized: "groupInsight.hero.subtitle")

                /// EN: Where your\nattention\ngoes
                /// RU: Куда уходит\nваше\nвнимание
                static let title = String(localized: "groupInsight.hero.title")

        }

        enum TopApps {
                /// EN: Last 7 days
                /// RU: За последние 7 дней
                static let emptySubtitle = String(localized: "groupInsight.topApps.emptySubtitle")

                /// EN: No data
                /// RU: Нет данных
                static let emptyTitle = String(localized: "groupInsight.topApps.emptyTitle")

                /// EN: Daily average
                /// RU: В среднем за день
                static let subtitle = String(localized: "groupInsight.topApps.subtitle")

                /// EN: Top distractions
                /// RU: Топ отвлечений
                static let title = String(localized: "groupInsight.topApps.title")

                /// EN: %dm
                /// RU: %dм
                static func usageMinutesFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "groupInsight.topApps.usageMinutesFormat"), arg0)
                }

        }

        enum WeeklyActivity {
                /// EN: Average screen time by day
                /// RU: Среднее экранное время по дням
                static let subtitle = String(localized: "groupInsight.weeklyActivity.subtitle")

                /// EN: Statistics for the last 7 days
                /// RU: Статистика за последние 7 дней
                static let title = String(localized: "groupInsight.weeklyActivity.title")

        }

    }

    enum Indicator {
        enum Empty {
                /// EN: Today
                /// RU: Сегодня
                static let today = String(localized: "indicator.empty.today")

                /// EN: It hasn't started yet today
                /// RU: Сегодня еще не начато
                static let todayNotStarted = String(localized: "indicator.empty.todayNotStarted")

        }

        enum Fill {
                /// EN: Excellent balance
                /// RU: Отличный баланс
                static let goodBalance = String(localized: "indicator.fill.goodBalance")

                /// EN: TODAY
                /// RU: СЕГОДНЯ
                static let today = String(localized: "indicator.fill.today")

        }

    }

    enum Main {
        enum Action {
                /// EN: New group
                /// RU: Новая группа
                static let newGroup = String(localized: "main.action.newGroup")

        }

        enum Empty {
                /// EN: Create group
                /// RU: Создать группу
                static let actionTitle = String(localized: "main.empty.actionTitle")

                /// EN: Choose apps and set limits for them
                /// RU: Выбери приложения и задай для них ограничения
                static let subtitle = String(localized: "main.empty.subtitle")

                /// EN: Start controlling apps
                /// RU: Начни контролировать приложения
                static let title = String(localized: "main.empty.title")

        }

        enum Groups {
                /// EN: %@ active
                /// RU: %@ активных
                static func activeCount(arg0: CVarArg) -> String {
                    String(format: String(localized: "main.groups.activeCount"), arg0)
                }

                /// EN: Your groups
                /// RU: Ваши группы
                static let title = String(localized: "main.groups.title")

        }

        enum Indicator {
                /// EN: 0%
                /// RU: 0%
                static let zeroPercent = String(localized: "main.indicator.zeroPercent")

        }

        enum NoAccess {
                /// EN: Open settings
                /// RU: Открыть настройки
                static let actionTitle = String(localized: "main.noAccess.actionTitle")

                /// EN: No data
                /// RU: Нет данных
                static let indicatorTitle = String(localized: "main.noAccess.indicatorTitle")

                /// EN: To apply restrictions and track groups, allow Screen Time access in Settings.
                /// RU: Чтобы применять ограничения и отслеживать группы, разрешите доступ к Screen Time в настройках.
                static let subtitle = String(localized: "main.noAccess.subtitle")

                /// EN: Access required
                /// RU: Требуется доступ
                static let title = String(localized: "main.noAccess.title")

        }

        enum Usage {
                /// EN: %@ of %@ (Limit exceeded)
                /// RU: %@ из %@ (Лимит превышен)
                static func limitExceededFormat(arg0: CVarArg, arg1: CVarArg) -> String {
                    String(format: String(localized: "main.usage.limitExceededFormat"), arg0, arg1)
                }

                /// EN: Paused
                /// RU: На паузе
                static let paused = String(localized: "main.usage.paused")

                /// EN: %@ of %@
                /// RU: %@ из %@
                static func progressFormat(arg0: CVarArg, arg1: CVarArg) -> String {
                    String(format: String(localized: "main.usage.progressFormat"), arg0, arg1)
                }

        }

    }

    enum Onboarding {
            /// EN: UNSTICK
            /// RU: ОТЛИПНИ
            static let logoTitle = String(localized: "onboarding.logoTitle")

            /// EN: You don’t have to spend hours endlessly scrolling. “Unstick” helps you pause in the moment of impulse and make a conscious choice.\n\nWhen you open a distracting app, we give you a pause — time to think, to say no, or to choose an action that really matters.
            /// RU: Ты не обязан тратить часы на бесконечный скролл. “Отлипни” помогает остановиться в момент импульса и сделать осознанный выбор.\n\nКогда ты открываешь отвлекающее приложение, мы даём тебе паузу — время подумать, отказаться или выбрать действие, которое действительно важно.
            static let subtitle = String(localized: "onboarding.subtitle")

            /// EN: Take control of your attention
            /// RU: Возьми контроль над своим вниманием
            static let title = String(localized: "onboarding.title")

    }

    enum RestrictionSetup {
        enum Break {
                /// EN: Duration
                /// RU: Длительность
                static let durationTitle = String(localized: "restrictionSetup.break.durationTitle")

                /// EN: %d min
                /// RU: %d мин
                static func minuteValueFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "restrictionSetup.break.minuteValueFormat"), arg0)
                }

                /// EN: Remind every
                /// RU: Напоминать каждые
                static let remindEveryTitle = String(localized: "restrictionSetup.break.remindEveryTitle")

                /// EN: The app reminds you to pause if you use it too long. This helps keep control and stop in time.
                /// RU: Приложение будет напоминать вам сделать паузу, если вы используете его слишком долго. Это поможет не терять контроль и вовремя остановиться.
                static let subtitle = String(localized: "restrictionSetup.break.subtitle")

                /// EN: Take a break
                /// RU: Сделайте перерыв
                static let title = String(localized: "restrictionSetup.break.title")

        }

        enum DailyLimit {
                /// EN: SCROLL TO ADJUST
                /// RU: ПРОКРУТИТЕ ДЛЯ НАСТРОЙКИ
                static let caption = String(localized: "restrictionSetup.dailyLimit.caption")

                /// EN: %d h
                /// RU: %d ч
                static func hourValueFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "restrictionSetup.dailyLimit.hourValueFormat"), arg0)
                }

                /// EN: %d min
                /// RU: %d мин
                static func minuteValueFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "restrictionSetup.dailyLimit.minuteValueFormat"), arg0)
                }

                /// EN: Daily limit
                /// RU: Лимит в день
                static let title = String(localized: "restrictionSetup.dailyLimit.title")

        }

        enum GroupName {
                /// EN: Enter name
                /// RU: Введите название
                static let placeholder = String(localized: "restrictionSetup.groupName.placeholder")

                /// EN: Group name
                /// RU: Название группы
                static let title = String(localized: "restrictionSetup.groupName.title")

        }

        enum Hero {
                /// EN: Create the ideal balance for your group
                /// RU: Создайте идеальный баланс для вашей группы
                static let subtitle = String(localized: "restrictionSetup.hero.subtitle")

                /// EN: Set up\nrestrictions
                /// RU: Настройте\nограничения
                static let title = String(localized: "restrictionSetup.hero.title")

        }

        enum MinutesPopover {
                /// EN: %d min
                /// RU: %d мин
                static func minuteValueFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "restrictionSetup.minutesPopover.minuteValueFormat"), arg0)
                }

        }

        enum OnDemand {
                /// EN: Extra time
                /// RU: Доп. время
                static let extraTimeTitle = String(localized: "restrictionSetup.onDemand.extraTimeTitle")

                /// EN: %d min
                /// RU: %d мин
                static func minuteValueFormat(arg0: CVarArg) -> String {
                    String(format: String(localized: "restrictionSetup.onDemand.minuteValueFormat"), arg0)
                }

                /// EN: The app remains paused to avoid distractions. If needed, you can open it for selected time.
                /// RU: Приложение будет оставаться приостановленным, чтобы не отвлекать вас. При необходимости вы можете открыть его на выбранное время.
                static let subtitle = String(localized: "restrictionSetup.onDemand.subtitle")

                /// EN: On-demand access
                /// RU: Доступ по запросу
                static let title = String(localized: "restrictionSetup.onDemand.title")

        }

    }

    enum Settings {
        enum About {
                /// EN: Privacy policy
                /// RU: Политика конфиденциальности
                static let privacyPolicy = String(localized: "settings.about.privacyPolicy")

                /// EN: Rate in App Store
                /// RU: Оценить в App Store
                static let rateInAppStore = String(localized: "settings.about.rateInAppStore")

                /// EN: Terms of use
                /// RU: Условия использования
                static let termsOfUse = String(localized: "settings.about.termsOfUse")

                /// EN: About app
                /// RU: О приложении
                static let title = String(localized: "settings.about.title")

                /// EN: Version
                /// RU: Версия
                static let version = String(localized: "settings.about.version")

                /// EN: 1.0.0
                /// RU: 1.0.0
                static let versionValue = String(localized: "settings.about.versionValue")

                /// EN: What's new
                /// RU: Что нового
                static let whatsNew = String(localized: "settings.about.whatsNew")

        }

        enum General {
                /// EN: Delayed resume
                /// RU: Отложенное возобновление
                static let deferredResume = String(localized: "settings.general.deferredResume")

                /// EN: 15 min
                /// RU: 15 мин
                static let deferredResumeValue = String(localized: "settings.general.deferredResumeValue")

                /// EN: Notifications
                /// RU: Уведомления
                static let notifications = String(localized: "settings.general.notifications")

                /// EN: Strict mode
                /// RU: Строгий режим
                static let strictMode = String(localized: "settings.general.strictMode")

                /// EN: General
                /// RU: Общие
                static let title = String(localized: "settings.general.title")

        }

        enum Personalization {
                /// EN: Appearance
                /// RU: Внешний вид
                static let appearance = String(localized: "settings.personalization.appearance")

                /// EN: Haptics and sound
                /// RU: Хаптика и звук
                static let hapticsAndSound = String(localized: "settings.personalization.hapticsAndSound")

                /// EN: Intervention tone
                /// RU: Тон интервенции
                static let interventionTone = String(localized: "settings.personalization.interventionTone")

                /// EN: Personalization
                /// RU: Персонализация
                static let title = String(localized: "settings.personalization.title")

        }

        enum Protection {
                /// EN: Protection from disabling
                /// RU: Защита от отключения
                static let disableProtection = String(localized: "settings.protection.disableProtection")

                /// EN: Passcode
                /// RU: Код доступа
                static let passcode = String(localized: "settings.protection.passcode")

                /// EN: Off
                /// RU: Выкл
                static let passcodeValue = String(localized: "settings.protection.passcodeValue")

                /// EN: Protection
                /// RU: Защита
                static let title = String(localized: "settings.protection.title")

        }

        enum Support {
                /// EN: Frequently asked questions
                /// RU: Часто задаваемые вопросы
                static let faq = String(localized: "settings.support.faq")

                /// EN: Feedback
                /// RU: Обратная связь
                static let feedback = String(localized: "settings.support.feedback")

                /// EN: Introduction
                /// RU: Введение
                static let introduction = String(localized: "settings.support.introduction")

                /// EN: Support
                /// RU: Поддержка
                static let title = String(localized: "settings.support.title")

        }

            /// EN: Settings
            /// RU: Настройки
            static let title = String(localized: "settings.title")

    }

    enum Statistics {
        enum Activity {
                /// EN: FRI
                /// RU: ПТ
                static let fri = String(localized: "statistics.activity.fri")

                /// EN: MON
                /// RU: ПН
                static let mon = String(localized: "statistics.activity.mon")

                /// EN: SAT
                /// RU: СБ
                static let sat = String(localized: "statistics.activity.sat")

                /// EN: Saved time by day
                /// RU: Сохранённое время по дням
                static let subtitle = String(localized: "statistics.activity.subtitle")

                /// EN: SUN
                /// RU: ВС
                static let sun = String(localized: "statistics.activity.sun")

                /// EN: THU
                /// RU: ЧТ
                static let thu = String(localized: "statistics.activity.thu")

                /// EN: Activity for the week
                /// RU: Активность за неделю
                static let title = String(localized: "statistics.activity.title")

                /// EN: TUE
                /// RU: ВТ
                static let tue = String(localized: "statistics.activity.tue")

                /// EN: WED
                /// RU: СР
                static let wed = String(localized: "statistics.activity.wed")

        }

        enum Metrics {
                /// EN: Canceled
                /// RU: Отмены
                static let canceledTitle = String(localized: "statistics.metrics.canceledTitle")

                /// EN: Focus score
                /// RU: Очки фокуса
                static let focusScoreTitle = String(localized: "statistics.metrics.focusScoreTitle")

                /// EN: Saved
                /// RU: Сохранено
                static let savedTitle = String(localized: "statistics.metrics.savedTitle")

                /// EN: Streak
                /// RU: Страйк
                static let streakTitle = String(localized: "statistics.metrics.streakTitle")

        }

    }
}