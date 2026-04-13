//
//  RestrictionSetupPresenter.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import Foundation

protocol RestrictionSetupModuleDelegate: AnyObject {
    func didFinishRestrictionSetup()
}

private enum RestrictionSetupDefaults {
    static let hourOptions = Array(0...12)
    static let minuteOptions = Array(stride(from: 0, through: 55, by: 5))
    static let breakMinuteOptions = Array(stride(from: 5, through: 60, by: 5))
    static let onDemandMinuteOptions = Array(stride(from: 5, through: 60, by: 5))
}

final class RestrictionSetupPresenter {
    private weak var view: RestrictionSetupViewProtocol?
    private weak var delegate: RestrictionSetupModuleDelegate?
    private let factory: RestrictionSetupFactoryProtocol
    private let useCases: IRestrictionSetupUseCases
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false

    private var groupName = GroupCreationDefaults.settings.groupName
    private var selectedHour = GroupCreationDefaults.settings.dailyLimitMinutes / 60
    private var selectedMinute = GroupCreationDefaults.settings.dailyLimitMinutes % 60
    private let hourOptions = RestrictionSetupDefaults.hourOptions
    private let minuteOptions = RestrictionSetupDefaults.minuteOptions
    private var breakReminderMinutes = GroupCreationDefaults.settings.breakSettings.remindEveryMinutes
    private var breakDurationMinutes = GroupCreationDefaults.settings.breakSettings.durationMinutes
    private let breakMinuteOptions = RestrictionSetupDefaults.breakMinuteOptions
    private var isBreakEnabled = GroupCreationDefaults.settings.breakSettings.isEnabled
    private var isOnDemandEnabled = GroupCreationDefaults.settings.onDemandSettings.isEnabled
    private var onDemandExtraMinutes = GroupCreationDefaults.settings.onDemandSettings.extraMinutes
    private let onDemandMinuteOptions = RestrictionSetupDefaults.onDemandMinuteOptions
    private var isContinueEnabled = true

    init(
        view: RestrictionSetupViewProtocol,
        factory: RestrictionSetupFactoryProtocol,
        useCases: IRestrictionSetupUseCases,
        delegate: RestrictionSetupModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.useCases = useCases
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension RestrictionSetupPresenter: RestrictionSetupPresenterProtocol {
    func viewLoaded() {
        reload()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}

    func didTapContinue() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let result = try await useCases.createGroup()

                switch result {
                case .createdActive:
                    delegate?.didFinishRestrictionSetup()
                }
            } catch {
                // TODO: Show user-facing alert UI for create/apply failure.
            }
        }
    }
}

private extension RestrictionSetupPresenter {
    func reload() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let result = await useCases.loadRestrictionSetup()

            switch result {
            case .ready(let settings):
                apply(settings: settings)
            }

            persistCurrentSettingsAndRender(isInitial: true, animatingDifferences: false)
            applyInitialSnapshotIfNeeded()
        }
    }

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
        let sections = factory.makeCollectionContent(input: makeSectionInput())
        view?.setContinueEnabled(isContinueEnabled)

        guard !isInitial else {
            pendingSections = sections
            return
        }

        dataSource.setSections(with: sections)
        dataSource.applySnapshot(animatingDifferences: animatingDifferences) { [weak self] in
            self?.view?.refreshCollectionLayout()
        }
    }

    func makeSectionInput() -> RestrictionSetupSectionInput {
        RestrictionSetupSectionInput(
            groupName: GroupNameInput(
                value: groupName,
                onValueChanged: { [weak self] value in
                    self?.didChangeGroupName(value)
                }
            ),
            dailyLimit: DailyLimitInput(
                hours: hourOptions,
                minutes: minuteOptions,
                selectedHour: selectedHour,
                selectedMinute: selectedMinute,
                onHourChanged: { [weak self] hour in
                    self?.didSelectHour(hour)
                },
                onMinuteChanged: { [weak self] minute in
                    self?.didSelectMinute(minute)
                }
            ),
            breakSettings: BreakSettingsInput(
                isEnabled: isBreakEnabled,
                reminderMinutes: breakReminderMinutes,
                durationMinutes: breakDurationMinutes,
                minuteOptions: breakMinuteOptions,
                onEnabledChanged: { [weak self] isOn in
                    self?.didChangeBreakEnabled(isOn)
                },
                onReminderSelected: { [weak self] minute in
                    self?.didSelectBreakReminder(minute)
                },
                onDurationSelected: { [weak self] minute in
                    self?.didSelectBreakDuration(minute)
                }
            ),
            onDemand: OnDemandInput(
                isEnabled: isOnDemandEnabled,
                extraMinutes: onDemandExtraMinutes,
                minuteOptions: onDemandMinuteOptions,
                onEnabledChanged: { [weak self] isOn in
                    self?.didChangeOnDemandEnabled(isOn)
                },
                onExtraTimeSelected: { [weak self] minute in
                    self?.didSelectOnDemandExtraTime(minute)
                }
            )
        )
    }

    func didSelectHour(_ value: Int) {
        guard selectedHour != value else { return }
        selectedHour = value
        persistCurrentSettingsAndRender()
    }

    func didSelectMinute(_ value: Int) {
        guard selectedMinute != value else { return }
        selectedMinute = value
        persistCurrentSettingsAndRender()
    }

    func didSelectBreakReminder(_ minute: Int) {
        guard breakMinuteOptions.contains(minute), breakReminderMinutes != minute else { return }
        breakReminderMinutes = minute
        persistCurrentSettingsAndRender()
    }

    func didSelectBreakDuration(_ minute: Int) {
        guard breakMinuteOptions.contains(minute), breakDurationMinutes != minute else { return }
        breakDurationMinutes = minute
        persistCurrentSettingsAndRender()
    }

    func didChangeBreakEnabled(_ isOn: Bool) {
        guard isBreakEnabled != isOn else { return }
        isBreakEnabled = isOn
        persistCurrentSettingsAndRender()
    }

    func didChangeOnDemandEnabled(_ isOn: Bool) {
        guard isOnDemandEnabled != isOn else { return }
        isOnDemandEnabled = isOn
        persistCurrentSettingsAndRender()
    }

    func didSelectOnDemandExtraTime(_ minute: Int) {
        guard onDemandMinuteOptions.contains(minute), onDemandExtraMinutes != minute else { return }
        onDemandExtraMinutes = minute
        persistCurrentSettingsAndRender()
    }

    func didChangeGroupName(_ value: String) {
        groupName = value
        persistCurrentSettingsAndRender()
    }

    func apply(settings: RestrictionSettings) {
        groupName = settings.groupName
        selectedHour = settings.dailyLimitMinutes / 60
        selectedMinute = settings.dailyLimitMinutes % 60
        isBreakEnabled = settings.breakSettings.isEnabled
        breakReminderMinutes = settings.breakSettings.remindEveryMinutes
        breakDurationMinutes = settings.breakSettings.durationMinutes
        isOnDemandEnabled = settings.onDemandSettings.isEnabled
        onDemandExtraMinutes = settings.onDemandSettings.extraMinutes
    }

    func makeCurrentSettings() -> RestrictionSettings {
        .init(
            groupName: groupName,
            dailyLimitMinutes: selectedHour * 60 + selectedMinute,
            breakSettings: .init(
                isEnabled: isBreakEnabled,
                remindEveryMinutes: breakReminderMinutes,
                durationMinutes: breakDurationMinutes
            ),
            onDemandSettings: .init(
                isEnabled: isOnDemandEnabled,
                extraMinutes: onDemandExtraMinutes
            )
        )
    }

    func persistCurrentSettingsAndRender(
        isInitial: Bool = false,
        animatingDifferences: Bool = true
    ) {
        let settings = makeCurrentSettings()
        Task { @MainActor [weak self] in
            guard let self else { return }
            isContinueEnabled = (try? await useCases.updateRestrictionSettings(settings: settings)) ?? false
            render(isInitial: isInitial, animatingDifferences: animatingDifferences)
            applyInitialSnapshotIfNeeded()
        }
    }
}
