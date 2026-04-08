//
//  MainPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import Foundation
import UIKit

protocol MainModuleDelegate: AnyObject {
    func showNextAction()
}

final class MainPresenter {
    private enum MockState {
        static let initial: ScreenState = .filled

        enum ScreenState {
            case empty
            case filled
        }
    }

    // MARK: - Private Properties

    private weak var view: MainViewProtocol?
    private weak var delegate: MainModuleDelegate?
    private let factory: MainFactoryProtocol
    private let dataSource: AnyCollectionDataSource
    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false

    // MARK: - Init

    init(
        view: MainViewProtocol,
        factory: MainFactoryProtocol,
        delegate: MainModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

// MARK: - MainPresenterProtocol

extension MainPresenter: MainPresenterProtocol {
    func viewLoaded() {
        bindActions()

        switch MockState.initial {
        case .empty:
            displayEmptyContent()
        case .filled:
            displayFilledContent()
        }
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}
    
    func nextAction() {
        delegate?.showNextAction()
    }
}

// MARK: - Private Methods

private extension MainPresenter {
    func bindActions() {
        factory.onDidTapActionButton = { [weak self] in
            self?.nextAction()
        }
    }

    func displayEmptyContent() {
        let data = makeEmptyData()

        pendingSections = []
        dataSource.clearSections()
        view?.display(state: .empty(data))
        view?.setCollectionHidden(true)
    }

    func displayFilledContent() {
        let data = makeFilledDataMock()
        let sections = factory.makeFilledCollectionContent(
            items: data.items,
            sectionHeader: data.sectionHeader,
            actionButtonTitle: data.state.actionTitle
        )

        view?.display(state: .filled(data.state))
        view?.setCollectionHidden(false)
        pendingSections = sections
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

    func makeEmptyData() -> MainEmptyStateModel {
        .init(
            title: L10n.Main.Empty.title,
            subtitle: L10n.Main.Empty.subtitle,
            actionTitle: L10n.Main.Empty.actionTitle,
            note: L10n.Main.Empty.note
        )
    }

    func makeFilledDataMock() -> MainFilledData {
        let items: [UsageSummaryCardModel] = [
            .init(
                title: "Соцсети",
                subtitle: "1ч 20м из 2ч",
                progress: 0.45,
                style: .primary,
                appIcons: [
                    .init(image: UIImage(systemName: "message.fill")),
                    .init(image: UIImage(systemName: "camera.fill")),
                    .init(image: UIImage(systemName: "bubble.left.and.bubble.right.fill"))
                ],
                extraCount: 1
            ),
            .init(
                title: "Развлечения",
                subtitle: "50м из 1ч",
                progress: 0.85,
                style: .warning,
                appIcons: [
                    .init(image: UIImage(systemName: "play.rectangle.fill")),
                    .init(image: UIImage(systemName: "tv.fill"))
                ],
                extraCount: 1
            ),
            .init(
                title: "Игры",
                subtitle: "45м из 30м (Лимит превышен)",
                progress: 1,
                style: .danger,
                appIcons: [
                    .init(image: UIImage(systemName: "gamecontroller.fill")),
                    .init(image: UIImage(systemName: "globe"))
                ],
                showsWarningIcon: true
            )
        ]

        return .init(
            state: .init(
                indicatorState: .fill(
                    .init(
                        title: L10n.Indicator.Fill.today,
                        value: "82%",
                        statusText: L10n.Indicator.Fill.goodBalance
                    )
                ),
                actionTitle: L10n.Main.Action.newGroup
            ),
            sectionHeader: .init(
                title: L10n.Main.Groups.title,
                subtitle: L10n.Main.Groups.activeCount(arg0: "\(items.count)")
            ),
            items: items
        )
    }
}

private extension MainPresenter {
    struct MainFilledData {
        let state: MainViewState.Filled
        let sectionHeader: MainGroupsSectionHeaderModel
        let items: [UsageSummaryCardModel]
    }
}
