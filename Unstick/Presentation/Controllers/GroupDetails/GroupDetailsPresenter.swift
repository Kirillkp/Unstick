//
//  GroupDetailsPresenter.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation
import UIKit

protocol GroupDetailsModuleDelegate: AnyObject {
    func didFinishGroupDetails()
}

final class GroupDetailsPresenter {
    private struct RestrictionFormState {
        var groupName: String
        var selectedHour: Int
        var selectedMinute: Int
        var isBreakEnabled: Bool
        var breakReminderMinutes: Int
        var breakDurationMinutes: Int
        var isOnDemandEnabled: Bool
        var onDemandExtraMinutes: Int

        init(settings: RestrictionSettings) {
            groupName = settings.groupName
            selectedHour = settings.dailyLimitMinutes / 60
            selectedMinute = settings.dailyLimitMinutes % 60
            isBreakEnabled = settings.breakSettings.isEnabled
            breakReminderMinutes = settings.breakSettings.remindEveryMinutes
            breakDurationMinutes = settings.breakSettings.durationMinutes
            isOnDemandEnabled = settings.onDemandSettings.isEnabled
            onDemandExtraMinutes = settings.onDemandSettings.extraMinutes
        }
    }

    private enum FormOptions {
        static let dailyLimitHours = Array(0...12)
        static let dailyLimitMinutes = Array(stride(from: 0, through: 55, by: 5))
        static let breakMinuteOptions = Array(stride(from: 5, through: 60, by: 5))
        static let onDemandMinuteOptions = Array(stride(from: 5, through: 60, by: 5))
    }

    private weak var view: GroupDetailsViewProtocol?
    private weak var delegate: GroupDetailsModuleDelegate?
    private let factory: GroupDetailsFactoryProtocol
    private let useCases: IGroupDetailsUseCases
    private let groupId: UUID
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false
    private var group: RestrictionGroup?
    private var appRows: [GroupDetailsAppRow] = []
    private var formState: RestrictionFormState?

    init(
        view: GroupDetailsViewProtocol,
        factory: GroupDetailsFactoryProtocol,
        useCases: IGroupDetailsUseCases,
        groupId: UUID,
        delegate: GroupDetailsModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.useCases = useCases
        self.groupId = groupId
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension GroupDetailsPresenter: GroupDetailsPresenterProtocol {
    func viewLoaded() {
        bindActions()
        reload()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}
}

private extension GroupDetailsPresenter {
    func bindActions() {
        factory.onDidTapStatusAction = { [weak self] in
            self?.didTapStatusAction()
        }
        factory.onDidTapUpdateAction = { [weak self] in
            self?.didTapUpdateAction()
        }
        factory.onDidTapDeleteAction = { [weak self] in
            self?.didTapDeleteAction()
        }
    }

    func didTapStatusAction() {
        guard let group else { return }

        Task { @MainActor [weak self] in
            guard let self else { return }

            do {
                switch group.status {
                case .active:
                    try await useCases.pauseGroup(groupId: group.id)
                case .paused:
                    try await useCases.resumeGroup(groupId: group.id)
                }
                reload()
            } catch {
                // TODO: Show user-facing alert UI for pause/resume failure.
            }
        }
    }

    func didTapDeleteAction() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                try await useCases.deleteGroup(groupId: groupId)
                delegate?.didFinishGroupDetails()
            } catch {
                // TODO: Show user-facing alert UI for delete failure.
            }
        }
    }

    func didTapUpdateAction() {
        guard
            let group,
            hasPendingChanges
        else {
            return
        }

        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                try await useCases.updateGroupSettings(
                    groupId: group.id,
                    settings: makeDraftSettings()
                )
                reload()
            } catch {
                // TODO: Show user-facing alert UI for group settings update failure.
            }
        }
    }

    func reload() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let result = await useCases.loadGroupDetails(groupId: groupId)
            switch result {
            case .notFound:
                delegate?.didFinishGroupDetails()
                return
            case .ready(let group, let appRows):
                self.group = group
                self.appRows = appRows
                formState = RestrictionFormState(settings: group.settings)
                view?.setNavigationTitle(group.settings.groupName)
            }

            renderSections(animatingDifferences: isInitialSnapshotApplied)
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

    func makeSectionInput() -> GroupDetailsSectionInput {
        guard let formState else {
            preconditionFailure("Form state must be initialized before rendering GroupDetails sections.")
        }

        let statusControl = makeStatusControlInput()
        let usageSummary = makeUsageSummaryInput()
        let updateAction = GroupDetailsSectionInput.UpdateAction(
            title: L10n.GroupDetails.Update.actionTitle,
            isEnabled: hasPendingChanges
        )

        return GroupDetailsSectionInput(
            statusControl: statusControl,
            usageSummary: usageSummary,
            groupName: formState.groupName,
            onGroupNameChanged: { [weak self] value in
                self?.updateForm(animatingDifferences: false) { form in
                    form.groupName = value
                }
            },
            dailyLimit: .init(
                hours: FormOptions.dailyLimitHours,
                minutes: FormOptions.dailyLimitMinutes,
                selectedHour: formState.selectedHour,
                selectedMinute: formState.selectedMinute,
                onHourChanged: { [weak self] value in
                    self?.updateForm(animatingDifferences: true) { form in
                        form.selectedHour = value
                    }
                },
                onMinuteChanged: { [weak self] value in
                    self?.updateForm(animatingDifferences: true) { form in
                        form.selectedMinute = value
                    }
                }
            ),
            breakSettings: .init(
                isEnabled: formState.isBreakEnabled,
                reminderMinutes: formState.breakReminderMinutes,
                durationMinutes: formState.breakDurationMinutes,
                minuteOptions: FormOptions.breakMinuteOptions,
                onEnabledChanged: { [weak self] isOn in
                    self?.updateForm(animatingDifferences: true) { form in
                        form.isBreakEnabled = isOn
                    }
                },
                onReminderSelected: { [weak self] value in
                    self?.updateForm(animatingDifferences: true) { form in
                        form.breakReminderMinutes = value
                    }
                },
                onDurationSelected: { [weak self] value in
                    self?.updateForm(animatingDifferences: true) { form in
                        form.breakDurationMinutes = value
                    }
                }
            ),
            onDemand: .init(
                isEnabled: formState.isOnDemandEnabled,
                extraMinutes: formState.onDemandExtraMinutes,
                minuteOptions: FormOptions.onDemandMinuteOptions,
                onEnabledChanged: { [weak self] isOn in
                    self?.updateForm(animatingDifferences: true) { form in
                        form.isOnDemandEnabled = isOn
                    }
                },
                onExtraTimeSelected: { [weak self] value in
                    self?.updateForm(animatingDifferences: true) { form in
                        form.onDemandExtraMinutes = value
                    }
                }
            ),
            appsTitle: L10n.GroupDetails.Apps.title,
            appRows: makeAppUsageRows(),
            updateAction: updateAction
        )
    }

    func makeStatusControlInput() -> GroupDetailsSectionInput.StatusControl {
        guard let group else {
            return .init(
                isActive: false,
                title: L10n.GroupDetails.Status.noDataTitle,
                subtitle: L10n.GroupDetails.Status.noDataSubtitle,
                actionTitle: L10n.GroupDetails.Status.noDataAction
            )
        }

        switch group.status {
        case .active:
            return .init(
                isActive: true,
                title: L10n.GroupDetails.Status.activeTitle,
                subtitle: L10n.GroupDetails.Status.activeSubtitle,
                actionTitle: L10n.GroupDetails.Status.activeAction
            )
        case .paused:
            return .init(
                isActive: false,
                title: L10n.GroupDetails.Status.pausedTitle,
                subtitle: L10n.GroupDetails.Status.pausedSubtitle,
                actionTitle: L10n.GroupDetails.Status.pausedAction
            )
        }
    }

    func makeUsageSummaryInput() -> GroupDetailsSectionInput.UsageSummary {
        let usedMinutes = group?.usedMinutesToday ?? 0
        let limitMinutes = max(group?.settings.dailyLimitMinutes ?? 1, 1)
        let progress = CGFloat(min(Double(usedMinutes) / Double(limitMinutes), 1))

        return .init(
            title: L10n.GroupDetails.Usage.title,
            usedMinutes: usedMinutes,
            limitMinutes: limitMinutes,
            progress: progress
        )
    }

    func makeAppUsageRows() -> [GroupDetailsSectionInput.AppUsageRow] {
        guard !appRows.isEmpty else { return [] }

        return appRows.map { app in
            .init(
                id: app.id,
                icon: UIImage(systemName: app.iconSystemName),
                name: app.title,
                usageText: L10n.Common.Duration.minutesShortFormat(arg0: "0")
            )
        }
    }

    var hasPendingChanges: Bool {
        guard let group, formState != nil else { return false }
        return makeDraftSettings() != group.settings
    }

    func makeDraftSettings() -> RestrictionSettings {
        guard let formState else {
            preconditionFailure("Form state must be initialized before building draft settings.")
        }

        return RestrictionSettings(
            groupName: formState.groupName,
            dailyLimitMinutes: formState.selectedHour * 60 + formState.selectedMinute,
            breakSettings: .init(
                isEnabled: formState.isBreakEnabled,
                remindEveryMinutes: formState.breakReminderMinutes,
                durationMinutes: formState.breakDurationMinutes
            ),
            onDemandSettings: .init(
                isEnabled: formState.isOnDemandEnabled,
                extraMinutes: formState.onDemandExtraMinutes
            )
        )
    }

    private func updateForm(
        animatingDifferences: Bool,
        mutate: (inout RestrictionFormState) -> Void
    ) {
        guard var formState else { return }
        mutate(&formState)
        self.formState = formState
        view?.setNavigationTitle(formState.groupName)
        renderSections(animatingDifferences: animatingDifferences)
    }

    func renderSections(animatingDifferences: Bool) {
        let input = makeSectionInput()
        if !isInitialSnapshotApplied {
            pendingSections = factory.makeCollectionContent(input: input)
            applyInitialSnapshotIfNeeded()
            return
        }

        let sections = factory.makeCollectionContent(input: input)
        dataSource.setSections(with: sections)
        dataSource.applySnapshot(animatingDifferences: animatingDifferences) { [weak self] in
            self?.view?.refreshCollectionLayout()
        }
    }
}
