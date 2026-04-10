//
//  GroupInsightPresenter.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation
import UIKit

protocol GroupInsightModuleDelegate: AnyObject {
    func showAppSelection()
}

final class GroupInsightPresenter {
    private weak var view: GroupInsightViewProtocol?
    private weak var delegate: GroupInsightModuleDelegate?
    private let factory: GroupInsightFactoryProtocol
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false

    init(
        view: GroupInsightViewProtocol,
        factory: GroupInsightFactoryProtocol,
        delegate: GroupInsightModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension GroupInsightPresenter: GroupInsightPresenterProtocol {
    func viewLoaded() {
        bindActions()

        let hero = makeHeroModel()
        let primaryActionTitle = makePrimaryActionTitle()
        let activity = makeWeeklyActivityModel()
        let topAppsHeader = makeTopAppsHeaderModel()
        let topApps = makeTopAppsModels()

        pendingSections = factory.makeCollectionContent(
            hero: hero,
            primaryActionTitle: primaryActionTitle,
            activity: activity,
            topAppsHeader: topAppsHeader,
            topApps: topApps
        )
        view?.display(
            state: .filled(
                hero: hero,
                primaryActionTitle: primaryActionTitle,
                activity: activity,
                topAppsHeader: topAppsHeader,
                topApps: topApps
            )
        )
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}

    func didTapPrimaryAction() {
        delegate?.showAppSelection()
    }
}

private extension GroupInsightPresenter {
    func bindActions() {
        factory.onDidTapPrimaryAction = { [weak self] in
            self?.didTapPrimaryAction()
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

    func makeHeroModel() -> HeroSectionModel {
        HeroSectionModel(
            title: "Куда уходит\nваше\nвнимание",
            subtitle: "Мы проанализировали использование приложений за неделю. Эти данные помогут вам вернуть контроль. Это статистика за последние 7 дней."
        )
    }

    func makePrimaryActionTitle() -> String {
        "Выберите приложения"
    }

    func makeWeeklyActivityModel() -> WeeklyActivityCardModel {
        WeeklyActivityCardModel(
            title: "Статистика за последние 7 дней",
            subtitle: "Среднее экранное время по дням",
            items: [
                .init(dayTitle: L10n.Statistics.Activity.mon, valueTitle: "3 ч 54 мин", value: 0.82, style: .accent),
                .init(dayTitle: L10n.Statistics.Activity.tue, valueTitle: "1 ч 12 мин", value: 0.28, style: .primary),
                .init(dayTitle: L10n.Statistics.Activity.wed, valueTitle: "2 ч 47 мин", value: 0.61, style: .primary),
                .init(dayTitle: L10n.Statistics.Activity.thu, valueTitle: "2 ч 39 мин", value: 0.56, style: .primary),
                .init(dayTitle: L10n.Statistics.Activity.fri, valueTitle: "4 ч 18 мин", value: 1.0, style: .accent),
                .init(dayTitle: L10n.Statistics.Activity.sat, valueTitle: "2 ч 05 мин", value: 0.46, style: .warning),
                .init(dayTitle: L10n.Statistics.Activity.sun, valueTitle: "1 ч 34 мин", value: 0.34, style: .primary)
            ]
        )
    }

    func makeTopAppsHeaderModel() -> MainGroupsSectionHeaderModel {
        .init(
            title: "Топ отвлечений",
            subtitle: "В среднем за день"
        )
    }

    func makeTopAppsModels() -> [UsageSummaryCardModel] {
        [
            .init(
                title: "Instagram",
                subtitle: "2ч 10м",
                progress: 1,
                style: .danger,
                appIcons: [.init(image: UIImage(systemName: "camera.macro"))]
            ),
            .init(
                title: "YouTube",
                subtitle: "1ч 45м",
                progress: 0.81,
                style: .warning,
                appIcons: [.init(image: UIImage(systemName: "play.rectangle.fill"))]
            ),
            .init(
                title: "TikTok",
                subtitle: "1ч 15м",
                progress: 0.58,
                style: .primary,
                appIcons: [.init(image: UIImage(systemName: "music.note"))]
            )
        ]
    }
}
