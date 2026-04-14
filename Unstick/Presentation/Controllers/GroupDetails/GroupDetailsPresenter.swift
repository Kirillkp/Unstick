//
//  GroupDetailsPresenter.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation
import UIKit

protocol GroupDetailsModuleDelegate: AnyObject {}

final class GroupDetailsPresenter {
    private weak var view: GroupDetailsViewProtocol?
    private weak var delegate: GroupDetailsModuleDelegate?
    private let factory: GroupDetailsFactoryProtocol
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false
    private var groupName = "Соцсети"
    private let dailyLimitHours = Array(0...12)
    private let dailyLimitMinutes = Array(stride(from: 0, through: 55, by: 5))
    private var selectedHour = 2
    private var selectedMinute = 30
    private let breakMinuteOptions = Array(stride(from: 5, through: 60, by: 5))
    private var isBreakEnabled = true
    private var breakReminderMinutes = 45
    private var breakDurationMinutes = 45
    private let onDemandMinuteOptions = Array(stride(from: 5, through: 60, by: 5))
    private var isOnDemandEnabled = true
    private var onDemandExtraMinutes = 45

    init(
        view: GroupDetailsViewProtocol,
        factory: GroupDetailsFactoryProtocol,
        delegate: GroupDetailsModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
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
        factory.onDidTapDeleteAction = { [weak self] in
            self?.didTapDeleteAction()
        }
    }

    func didTapStatusAction() {
        // Intentionally empty for the scaffold step.
    }

    func didTapDeleteAction() {
        // Intentionally empty for the scaffold step.
    }

    func reload() {
        let input = makeSectionInput()
        pendingSections = factory.makeCollectionContent(input: input)
        applyInitialSnapshotIfNeeded()
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
        GroupDetailsSectionInput(
            statusControl: .init(
                isActive: true,
                title: "АКТИВНА",
                subtitle: "Ограничения применяются ко всем приложениям в этой группе.",
                actionTitle: "Приостановить группу"
            ),
            usageSummary: .init(
                title: "ИСПОЛЬЗОВАНО СЕГОДНЯ",
                usedMinutes: 80,
                limitMinutes: 120,
                progress: 0.67
            ),
            groupName: groupName,
            onGroupNameChanged: { [weak self] value in
                self?.groupName = value
            },
            dailyLimit: .init(
                hours: dailyLimitHours,
                minutes: dailyLimitMinutes,
                selectedHour: selectedHour,
                selectedMinute: selectedMinute,
                onHourChanged: { [weak self] value in
                    self?.selectedHour = value
                },
                onMinuteChanged: { [weak self] value in
                    self?.selectedMinute = value
                }
            ),
            breakSettings: .init(
                isEnabled: isBreakEnabled,
                reminderMinutes: breakReminderMinutes,
                durationMinutes: breakDurationMinutes,
                minuteOptions: breakMinuteOptions,
                onEnabledChanged: { [weak self] isOn in
                    self?.isBreakEnabled = isOn
                },
                onReminderSelected: { [weak self] value in
                    self?.breakReminderMinutes = value
                },
                onDurationSelected: { [weak self] value in
                    self?.breakDurationMinutes = value
                }
            ),
            onDemand: .init(
                isEnabled: isOnDemandEnabled,
                extraMinutes: onDemandExtraMinutes,
                minuteOptions: onDemandMinuteOptions,
                onEnabledChanged: { [weak self] isOn in
                    self?.isOnDemandEnabled = isOn
                },
                onExtraTimeSelected: { [weak self] value in
                    self?.onDemandExtraMinutes = value
                }
            ),
            appsTitle: "Приложения в группе",
            appRows: [
                .init(
                    id: UUID(),
                    icon: UIImage(systemName: "medal.fill"),
                    name: "Facebook",
                    usageText: "45 мин"
                ),
                .init(
                    id: UUID(),
                    icon: UIImage(systemName: "camera.aperture"),
                    name: "Instagram",
                    usageText: "35 мин"
                ),
                .init(
                    id: UUID(),
                    icon: UIImage(systemName: "music.note"),
                    name: "TikTok",
                    usageText: "0 мин"
                )
            ]
        )
    }
}
