//
//  RestrictionSetupPresenter.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import Foundation

protocol RestrictionSetupModuleDelegate: AnyObject {}

private enum RestrictionSetupDefaults {
    static let groupName = "Соцсети и видео"
    static let selectedHour = 2
    static let selectedMinute = 30
    static let hourOptions = Array(0...12)
    static let minuteOptions = Array(stride(from: 0, through: 55, by: 5))

    static let breakReminderMinutes = 45
    static let breakDurationMinutes = 5
    static let breakMinuteOptions = Array(stride(from: 5, through: 60, by: 5))
    static let isBreakEnabled = true

    static let isOnDemandEnabled = true
    static let onDemandExtraMinutes = 15
    static let onDemandMinuteOptions = Array(stride(from: 5, through: 60, by: 5))
}

final class RestrictionSetupPresenter {
    private weak var view: RestrictionSetupViewProtocol?
    private weak var delegate: RestrictionSetupModuleDelegate?
    private let factory: RestrictionSetupFactoryProtocol
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false

    private var groupName = RestrictionSetupDefaults.groupName
    private var selectedHour = RestrictionSetupDefaults.selectedHour
    private var selectedMinute = RestrictionSetupDefaults.selectedMinute
    private let hourOptions = RestrictionSetupDefaults.hourOptions
    private let minuteOptions = RestrictionSetupDefaults.minuteOptions
    private var breakReminderMinutes = RestrictionSetupDefaults.breakReminderMinutes
    private var breakDurationMinutes = RestrictionSetupDefaults.breakDurationMinutes
    private let breakMinuteOptions = RestrictionSetupDefaults.breakMinuteOptions
    private var isBreakEnabled = RestrictionSetupDefaults.isBreakEnabled
    private var isOnDemandEnabled = RestrictionSetupDefaults.isOnDemandEnabled
    private var onDemandExtraMinutes = RestrictionSetupDefaults.onDemandExtraMinutes
    private let onDemandMinuteOptions = RestrictionSetupDefaults.onDemandMinuteOptions

    init(
        view: RestrictionSetupViewProtocol,
        factory: RestrictionSetupFactoryProtocol,
        delegate: RestrictionSetupModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension RestrictionSetupPresenter: RestrictionSetupPresenterProtocol {
    func viewLoaded() {
        render(isInitial: true)
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}

    func didTapContinue() {}
}

private extension RestrictionSetupPresenter {
    func applyInitialSnapshotIfNeeded() {
        guard !isInitialSnapshotApplied, !pendingSections.isEmpty else { return }

        isInitialSnapshotApplied = true
        dataSource.setSections(with: pendingSections)
        pendingSections = []
        dataSource.applySnapshot(animatingDifferences: false) { [weak self] in
            self?.view?.refreshCollectionLayout()
        }
    }

    func render(
        isInitial: Bool = false,
        animatingDifferences: Bool = true
    ) {
        let state = makeState()
        let sections = factory.makeCollectionContent(
            hero: makeHeroModel(),
            groupName: makeGroupNameModel(),
            dailyLimit: makeDailyLimitModel(),
            breakSettings: makeBreakSettingsModel(),
            onDemand: makeOnDemandModel()
        )

        view?.display(state: state)

        guard !isInitial else {
            pendingSections = sections
            return
        }

        dataSource.setSections(with: sections)
        dataSource.applySnapshot(animatingDifferences: animatingDifferences) { [weak self] in
            self?.view?.refreshCollectionLayout()
        }
    }

    func makeState() -> RestrictionSetupViewState {
        .filled(
            hero: makeHeroModel(),
            groupName: makeGroupNameModel(),
            dailyLimit: makeDailyLimitModel(),
            breakSettings: makeBreakSettingsModel(),
            onDemand: makeOnDemandModel(),
            continueTitle: "Создать группу",
            isContinueEnabled: true
        )
    }

    func makeHeroModel() -> HeroSectionModel {
        HeroSectionModel(
            title: "Настройте\nограничения",
            subtitle: "Создайте идеальный баланс для вашей группы"
        )
    }

    func makeGroupNameModel() -> RestrictionSetupGroupNameCardModel {
        RestrictionSetupGroupNameCardModel(
            id: UUID(uuidString: "B4B9A39B-E3F4-4266-B4E7-A6F54549F0FC") ?? UUID(),
            title: "Название группы",
            value: groupName,
            placeholder: "Введите название",
            onValueChanged: { [weak self] value in
                self?.didChangeGroupName(value)
            }
        )
    }

    func makeDailyLimitModel() -> RestrictionSetupDailyLimitCardModel {
        RestrictionSetupDailyLimitCardModel(
            id: UUID(uuidString: "5A72B4E3-14BD-4764-9BA5-CE8606A59645") ?? UUID(),
            title: "Лимит в день",
            hours: hourOptions,
            minutes: minuteOptions,
            selectedHour: selectedHour,
            selectedMinute: selectedMinute,
            caption: "ПРОКРУТИТЕ ДЛЯ НАСТРОЙКИ",
            onHourChanged: { [weak self] hour in
                self?.didSelectHour(hour)
            },
            onMinuteChanged: { [weak self] minute in
                self?.didSelectMinute(minute)
            }
        )
    }

    func makeBreakSettingsModel() -> RestrictionSetupBreakCardModel {
        RestrictionSetupBreakCardModel(
            id: UUID(uuidString: "56CE9528-6508-4581-A018-E40FE9864D72") ?? UUID(),
            title: "Сделайте перерыв",
            subtitle: "Приложение будет напоминать вам сделать паузу, если вы используете его слишком долго. Это поможет не терять контроль и вовремя остановиться.",
            isEnabled: isBreakEnabled,
            remindEveryTitle: "Напоминать каждые",
            remindEveryValue: "\(breakReminderMinutes) мин",
            remindEverySelectedMinute: breakReminderMinutes,
            durationTitle: "Длительность",
            durationValue: "\(breakDurationMinutes) мин",
            durationSelectedMinute: breakDurationMinutes,
            minuteOptions: breakMinuteOptions,
            onEnabledChanged: { [weak self] isOn in
                self?.didChangeBreakEnabled(isOn)
            },
            onRemindEverySelected: { [weak self] minute in
                self?.didSelectBreakReminder(minute)
            },
            onDurationSelected: { [weak self] minute in
                self?.didSelectBreakDuration(minute)
            }
        )
    }

    func makeOnDemandModel() -> RestrictionSetupOnDemandCardModel {
        RestrictionSetupOnDemandCardModel(
            id: UUID(uuidString: "91D0C6BB-E261-4B37-AEFF-3B554A76123D") ?? UUID(),
            title: "Доступ по запросу",
            subtitle: "Приложение будет оставаться приостановленным, чтобы не отвлекать вас. При необходимости вы можете открыть его на выбранное время.",
            extraTimeTitle: "Доп. время",
            extraTimeValue: "\(onDemandExtraMinutes) мин",
            extraTimeSelectedMinute: onDemandExtraMinutes,
            minuteOptions: onDemandMinuteOptions,
            isEnabled: isOnDemandEnabled,
            onToggleChanged: { [weak self] isOn in
                self?.didChangeOnDemandEnabled(isOn)
            },
            onExtraTimeSelected: { [weak self] minute in
                self?.didSelectOnDemandExtraTime(minute)
            }
        )
    }

    func didSelectHour(_ value: Int) {
        guard selectedHour != value else { return }
        selectedHour = value
        render()
    }

    func didSelectMinute(_ value: Int) {
        guard selectedMinute != value else { return }
        selectedMinute = value
        render()
    }

    func didSelectBreakReminder(_ minute: Int) {
        guard breakMinuteOptions.contains(minute), breakReminderMinutes != minute else { return }
        breakReminderMinutes = minute
        render()
    }

    func didSelectBreakDuration(_ minute: Int) {
        guard breakMinuteOptions.contains(minute), breakDurationMinutes != minute else { return }
        breakDurationMinutes = minute
        render()
    }

    func didChangeBreakEnabled(_ isOn: Bool) {
        guard isBreakEnabled != isOn else { return }
        isBreakEnabled = isOn
        render()
    }

    func didChangeOnDemandEnabled(_ isOn: Bool) {
        guard isOnDemandEnabled != isOn else { return }
        isOnDemandEnabled = isOn
        render()
    }

    func didSelectOnDemandExtraTime(_ minute: Int) {
        guard onDemandMinuteOptions.contains(minute), onDemandExtraMinutes != minute else { return }
        onDemandExtraMinutes = minute
        render()
    }

    func didChangeGroupName(_ value: String) {
        groupName = value
    }
}
