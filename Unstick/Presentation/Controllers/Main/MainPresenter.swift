//
//  MainPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//

import Foundation
import UIKit

protocol MainModuleDelegate: AnyObject {
    func showNextAction()
}

@MainActor
final class MainPresenter {
    private enum PrimaryAction {
        case createGroup
        case openSettings
    }

    private weak var view: MainViewProtocol?
    private weak var delegate: MainModuleDelegate?
    private let factory: MainFactoryProtocol
    private let loadMainScreenUseCase: ILoadMainScreenUseCase
    private let openSettingsForAccessUseCase: IOpenSettingsForAccessUseCase
    private let dataSource: AnyCollectionDataSource

    private var primaryAction: PrimaryAction = .createGroup
    private var hasAppliedInitialSnapshot = false

    init(
        view: MainViewProtocol,
        factory: MainFactoryProtocol,
        loadMainScreenUseCase: ILoadMainScreenUseCase,
        openSettingsForAccessUseCase: IOpenSettingsForAccessUseCase,
        delegate: MainModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.loadMainScreenUseCase = loadMainScreenUseCase
        self.openSettingsForAccessUseCase = openSettingsForAccessUseCase
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension MainPresenter: MainPresenterProtocol {
    func viewLoaded() {
        bindActions()
        reloadMainState()
    }

    func viewWillAppear(_ animated: Bool) {
        reloadMainState()
    }

    func viewDidAppear(_ animated: Bool) {
        if !hasAppliedInitialSnapshot {
            dataSource.applySnapshot(animatingDifferences: false) { [weak self] in
                self?.view?.refreshCollectionLayout()
            }
            hasAppliedInitialSnapshot = true
        }
    }

    func viewWillDisappear(_ animated: Bool) {}

    func nextAction() {
        switch primaryAction {
        case .createGroup:
            delegate?.showNextAction()
        case .openSettings:
            openSettingsForAccessUseCase.execute()
        }
    }
}

// MARK: - Lifecycle Helpers

private extension MainPresenter {
    func bindActions() {
        factory.onDidTapActionButton = { [weak self] in
            self?.nextAction()
        }
    }

    func reloadMainState() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let result = await loadMainScreenUseCase.execute()
            self.render(result: result)
        }
    }
}

// MARK: - Screen Rendering

private extension MainPresenter {
    func render(result: LoadMainScreenResult) {
        switch result {
        case .noAccess:
            renderNoAccessEmptyState()
        case .empty:
            renderEmptyState()
        case .filled(let groups):
            renderFilledState(groups: groups)
        }
    }

    func renderNoAccessEmptyState() {
        primaryAction = .openSettings
        dataSource.clearSections()

        let indicatorState = IndicatorView.State.empty(
            .init(
                title: L10n.Main.NoAccess.indicatorTitle,
                subtitle: ""
            )
        )

        let emptyModel = MainEmptyStateModel(
            title: L10n.Main.NoAccess.title,
            subtitle: L10n.Main.NoAccess.subtitle,
            actionTitle: L10n.Main.NoAccess.actionTitle
        )

        view?.display(state: .noAccess(
            MainViewState.Empty(
                indicatorState: indicatorState,
                emptyView: emptyModel
            )
        ))
        view?.setCollectionHidden(true)
        applySnapshot(animatingDifferences: false)
    }

    func renderEmptyState() {
        primaryAction = .createGroup
        dataSource.clearSections()

        let indicatorState = IndicatorView.State.empty(.init())
        let emptyModel = MainEmptyStateModel(
            title: L10n.Main.Empty.title,
            subtitle: L10n.Main.Empty.subtitle,
            actionTitle: L10n.Main.Empty.actionTitle
        )

        view?.display(state: .empty(
            MainViewState.Empty(
                indicatorState: indicatorState,
                emptyView: emptyModel
            )
        ))
        view?.setCollectionHidden(true)
        applySnapshot(animatingDifferences: false)
    }

    func renderFilledState(groups: [RestrictionGroup]) {
        primaryAction = .createGroup

        let models = groups.map(makeUsageSummaryModel)
        let state = MainViewState.Filled(
            indicatorState: .fill(
                .init(
                    title: L10n.Indicator.Fill.today,
                    value: makeIndicatorValue(groups: groups),
                    statusText: L10n.Indicator.Fill.goodBalance
                )
            ),
            actionTitle: L10n.Main.Action.newGroup
        )

        let sections = factory.makeFilledCollectionContent(
            items: models,
            sectionHeader: .init(
                title: L10n.Main.Groups.title,
                subtitle: L10n.Main.Groups.activeCount(arg0: "\(groups.count)")
            ),
            actionButtonTitle: state.actionTitle
        )

        view?.display(state: .filled(state))
        view?.setCollectionHidden(false)

        dataSource.setSections(with: sections)
        applySnapshot(animatingDifferences: true)
    }

    func applySnapshot(animatingDifferences: Bool) {
        dataSource.applySnapshot(animatingDifferences: animatingDifferences) { [weak self] in
            self?.view?.refreshCollectionLayout()
        }
    }
}

// MARK: - Collection And UsageSummary Mapping

private extension MainPresenter {
    struct GroupUsageMetrics {
        let usedMinutes: Int
        let limitMinutes: Int
        let usagePercent: Double
        let progressValue: CGFloat
    }

    func makeUsageSummaryModel(from group: RestrictionGroup) -> UsageSummaryCardModel {
        let metrics = makeUsageMetrics(from: group)
        let style = makeCardStyle(for: group, metrics: metrics)
        let subtitle = makeCardSubtitle(for: group, metrics: metrics)
        let showsWarningIcon = shouldShowWarningIcon(for: group)

        return .init(
            title: group.settings.groupName,
            subtitle: subtitle,
            progress: metrics.progressValue,
            style: style,
            appIcons: [
                .init(image: UIImage(systemName: "square.stack.3d.up.fill"))
            ],
            showsWarningIcon: showsWarningIcon
        )
    }

    func makeUsageMetrics(from group: RestrictionGroup) -> GroupUsageMetrics {
        let limit = max(group.settings.dailyLimitMinutes, 1)
        let used = max(group.usedMinutesToday, 0)
        let usagePercent = (Double(used) / Double(limit)) * 100
        let progressValue = CGFloat(min(Double(used) / Double(limit), 1))

        return GroupUsageMetrics(
            usedMinutes: used,
            limitMinutes: limit,
            usagePercent: usagePercent,
            progressValue: progressValue
        )
    }

    func makeCardStyle(
        for group: RestrictionGroup,
        metrics: GroupUsageMetrics
    ) -> UsageSummaryCardModel.Style {
        guard group.status != .configurationError else {
            return .danger
        }

        if metrics.usagePercent >= 90 {
            return .danger
        }
        if metrics.usagePercent < 50 {
            return .primary
        }
        return .warning
    }

    func makeCardSubtitle(
        for group: RestrictionGroup,
        metrics: GroupUsageMetrics
    ) -> String {
        if group.status == .configurationError {
            return L10n.Main.Usage.configurationError
        }
        if group.status == .paused {
            return L10n.Main.Usage.paused
        }
        if metrics.usedMinutes >= metrics.limitMinutes {
            return L10n.Main.Usage.limitExceededFormat(
                arg0: formatMinutes(metrics.usedMinutes),
                arg1: formatMinutes(metrics.limitMinutes)
            )
        }

        return L10n.Main.Usage.progressFormat(
            arg0: formatMinutes(metrics.usedMinutes),
            arg1: formatMinutes(metrics.limitMinutes)
        )
    }

    func shouldShowWarningIcon(for group: RestrictionGroup) -> Bool {
        group.status == .configurationError
    }

    func makeIndicatorValue(groups: [RestrictionGroup]) -> String {
        guard !groups.isEmpty else { return L10n.Main.Indicator.zeroPercent }

        let activeCount = groups.filter { $0.status == .active }.count
        let ratio = Int((Double(activeCount) / Double(groups.count)) * 100)
        return "\(ratio)%"
    }

    func formatMinutes(_ minutes: Int) -> String {
        let safeMinutes = max(minutes, 0)
        let hours = safeMinutes / 60
        let restMinutes = safeMinutes % 60

        if hours == 0 {
            return L10n.Common.Duration.minutesShortFormat(arg0: "\(restMinutes)")
        }
        if restMinutes == 0 {
            return L10n.Common.Duration.hoursShortFormat(arg0: "\(hours)")
        }
        return L10n.Common.Duration.hoursMinutesShortFormat(
            arg0: "\(hours)",
            arg1: "\(restMinutes)"
        )
    }
}
