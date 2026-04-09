//
//  SettingsPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//
//

import Foundation

protocol SettingsModuleDelegate: AnyObject {}

final class SettingsPresenter {
    private weak var view: SettingsViewProtocol?
    private weak var delegate: SettingsModuleDelegate?
    private let factory: SettingsFactoryProtocol
    private let dataSource: AnyCollectionDataSource
    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false

    init(
        view: SettingsViewProtocol,
        factory: SettingsFactoryProtocol,
        delegate: SettingsModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    func viewLoaded() {
        displayFilledContent()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}
}

private extension SettingsPresenter {
    func displayFilledContent() {
        let state = factory.makeFilledState()
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
