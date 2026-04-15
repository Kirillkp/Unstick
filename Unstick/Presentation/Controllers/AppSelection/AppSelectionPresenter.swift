//
//  AppSelectionPresenter.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation
import FamilyControls

protocol AppSelectionModuleDelegate: AnyObject {
    func showRestrictionSetup()
}

final class AppSelectionPresenter {
    private weak var view: AppSelectionViewProtocol?
    private weak var delegate: AppSelectionModuleDelegate?
    private let factory: AppSelectionFactoryProtocol
    private let useCases: IAppSelectionUseCases
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false
    private var isContinueInFlight = false
    private var currentSelection = FamilyActivitySelection()
    private var currentSummary = SelectionSummary(
        selectedApplicationsCount: 0,
        selectedCategoriesCount: 0,
        selectedWebDomainsCount: 0
    )

    init(
        view: AppSelectionViewProtocol,
        factory: AppSelectionFactoryProtocol,
        useCases: IAppSelectionUseCases,
        delegate: AppSelectionModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.useCases = useCases
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
    }
}

extension AppSelectionPresenter: AppSelectionPresenterProtocol {
    func viewLoaded() {
        reload()
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}

    func didTapSelectApps() {
        guard !isContinueInFlight else { return }
        view?.presentFamilyActivityPicker(
            selection: currentSelection,
            onSelectionUpdated: { [weak self] updatedSelection in
                self?.didUpdatePickerSelection(updatedSelection)
            }
        )
    }

    func didUpdatePickerSelection(_ selection: FamilyActivitySelection) {
        currentSelection = selection
        Task { @MainActor [weak self] in
            guard let self else { return }
            _ = await useCases.updateSelection(selection: selection)
            if case .ready(_, let summary) = await useCases.loadAppSelection() {
                currentSummary = summary
            }
            render(animatingDifferences: true)
        }
    }

    func didTapContinue() {
        guard !isContinueInFlight else { return }
        isContinueInFlight = true
        view?.setContinueEnabled(false)
        view?.setSelectAppsActionEnabled(false)

        do {
            try useCases.confirmSelection(selection: currentSelection)
            delegate?.showRestrictionSetup()
        } catch {
            isContinueInFlight = false
            AppErrorHandler.handle(error, context: "app_selection.confirm_selection")
            render(animatingDifferences: true)
        }
    }
}

private extension AppSelectionPresenter {
    func reload() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let result = await useCases.loadAppSelection()
            if case .ready(let selection, let summary) = result {
                currentSelection = selection
                currentSummary = summary
            }
            render(isInitial: true, animatingDifferences: false)
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
        animatingDifferences: Bool
    ) {
        let sections = factory.makeCollectionContent(summary: currentSummary)
        let isContinueEnabled = !currentSummary.isEmpty && !isContinueInFlight

        view?.setContinueEnabled(isContinueEnabled)
        view?.setSelectAppsActionEnabled(!isContinueInFlight)

        guard !isInitial else {
            pendingSections = sections
            return
        }

        guard isInitialSnapshotApplied else {
            pendingSections = sections
            return
        }

        dataSource.setSections(with: sections)
        dataSource.applySnapshot(animatingDifferences: animatingDifferences) { [weak self] in
            self?.view?.refreshCollectionLayout()
        }
    }
}
