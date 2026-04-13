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
    private let useCases: IGroupInsightUseCases
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false

    init(
        view: GroupInsightViewProtocol,
        factory: GroupInsightFactoryProtocol,
        useCases: IGroupInsightUseCases,
        delegate: GroupInsightModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.useCases = useCases
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension GroupInsightPresenter: GroupInsightPresenterProtocol {
    func viewLoaded() {
        bindActions()
        reload()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}

    func didTapPrimaryAction() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            guard (try? await useCases.continueFromInsight()) != nil else { return }
            delegate?.showAppSelection()
        }
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

    func reload() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let result = await useCases.loadGroupInsight()
            render(result: result)
            applyInitialSnapshotIfNeeded()
        }
    }

    func render(result: LoadGroupInsightResult) {
        let activityItems: [GroupInsightActivityItem]
        let topApps: [UsageApp]

        switch result {
        case .noAccess:
            activityItems = []
            topApps = []
        case .content(_, let weeklyActivity, let apps):
            activityItems = weeklyActivity
            topApps = apps
        }

        pendingSections = factory.makeCollectionContent(
            activityItems: activityItems,
            topApps: topApps
        )
    }
}
