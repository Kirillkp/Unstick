//
//  StatisticsPresenter.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import Foundation
import UIKit

protocol StatisticsModuleDelegate: AnyObject {}

final class StatisticsPresenter {
    private weak var view: StatisticsViewProtocol?
    private weak var delegate: StatisticsModuleDelegate?
    private let factory: StatisticsFactoryProtocol
    private let dataSource: AnyCollectionDataSource
    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false

    init(
        view: StatisticsViewProtocol,
        factory: StatisticsFactoryProtocol,
        delegate: StatisticsModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension StatisticsPresenter: StatisticsPresenterProtocol {
    func viewLoaded() {
        displayFilledContent()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}
}

private extension StatisticsPresenter {
    func displayFilledContent() {
        let state = StatisticsViewState.Filled(
            hero: .init(
                badge: StatisticsMockData.Hero.badge,
                title: StatisticsMockData.Hero.title,
                highlightedTexts: [
                    StatisticsMockData.Hero.highlightedHours,
                    StatisticsMockData.Hero.highlightedMinutes
                ],
                subtitle: StatisticsMockData.Hero.subtitle
            ),
            metrics: [
                .init(
                    iconSystemName: "hourglass",
                    title: L10n.Statistics.Metrics.savedTitle,
                    value: StatisticsMockData.Metrics.savedValue
                ),
                .init(
                    iconSystemName: "xmark.circle",
                    title: L10n.Statistics.Metrics.canceledTitle,
                    value: StatisticsMockData.Metrics.canceledValue
                ),
                .init(
                    iconSystemName: "flame",
                    title: L10n.Statistics.Metrics.streakTitle,
                    value: StatisticsMockData.Metrics.streakValue
                ),
                .init(
                    iconSystemName: "lightbulb",
                    title: L10n.Statistics.Metrics.focusScoreTitle,
                    value: StatisticsMockData.Metrics.focusScoreValue
                )
            ],
            activity: .init(
                title: L10n.Statistics.Activity.title,
                subtitle: L10n.Statistics.Activity.subtitle,
                items: [
                    .init(dayTitle: L10n.Statistics.Activity.mon, valueTitle: StatisticsMockData.Activity.monValueTitle, value: 0.60, style: .primary),
                    .init(dayTitle: L10n.Statistics.Activity.tue, valueTitle: StatisticsMockData.Activity.tueValueTitle, value: 0.88, style: .primary),
                    .init(dayTitle: L10n.Statistics.Activity.wed, valueTitle: StatisticsMockData.Activity.wedValueTitle, value: 0.52, style: .warning),
                    .init(dayTitle: L10n.Statistics.Activity.thu, valueTitle: StatisticsMockData.Activity.thuValueTitle, value: 0.80, style: .primary),
                    .init(dayTitle: L10n.Statistics.Activity.fri, valueTitle: StatisticsMockData.Activity.friValueTitle, value: 1.0, style: .accent),
                    .init(dayTitle: L10n.Statistics.Activity.sat, valueTitle: StatisticsMockData.Activity.satValueTitle, value: 0.58, style: .primary),
                    .init(dayTitle: L10n.Statistics.Activity.sun, valueTitle: StatisticsMockData.Activity.sunValueTitle, value: 0.36, style: .warning)
                ]
            ),
            analysis: [
                .init(
                    iconSystemName: "exclamationmark.triangle",
                    title: StatisticsMockData.Analysis.instagramTriggerTitle,
                    subtitle: StatisticsMockData.Analysis.instagramTriggerSubtitle,
                    style: .primary
                ),
                .init(
                    iconSystemName: "moon.zzz",
                    title: StatisticsMockData.Analysis.criticalWindowTitle,
                    subtitle: StatisticsMockData.Analysis.criticalWindowSubtitle,
                    style: .neutral
                )
            ]
        )
        let sections = factory.makeCollectionContent(for: state)

        view?.display(state: .filled(state))
        pendingSections = sections
    }

    func applyInitialSnapshotIfNeeded() {
        guard !isInitialSnapshotApplied else { return }

        isInitialSnapshotApplied = true
        dataSource.setSections(with: pendingSections)
        pendingSections = []
        dataSource.applySnapshot(animatingDifferences: false) { [weak self] in
            self?.view?.refreshCollectionLayout()
        }
    }
}
