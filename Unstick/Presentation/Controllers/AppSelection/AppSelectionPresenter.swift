//
//  AppSelectionPresenter.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

protocol AppSelectionModuleDelegate: AnyObject {
    func showRestrictionSetup()
}

final class AppSelectionPresenter {
    private struct AppState {
        let id: UUID
        let iconSystemName: String
        let title: String
        var isSelected: Bool
    }

    private struct CategoryState {
        let id: UUID
        let iconSystemName: String
        let title: String
        var appRows: [AppState]
    }

    private weak var view: AppSelectionViewProtocol?
    private weak var delegate: AppSelectionModuleDelegate?
    private let factory: AppSelectionFactoryProtocol
    private let useCases: IAppSelectionUseCases
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false
    private var expandedCategoryIDs: Set<UUID> = []
    private var categories: [CategoryState]

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
        self.categories = []
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

    func didTapContinue() {
        do {
            try useCases.confirmSelection(selection: makeSelectionPayload())
            delegate?.showRestrictionSetup()
        } catch {
            render(animatingDifferences: true)
        }
    }
}

private extension AppSelectionPresenter {
    func reload() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let result = await useCases.loadAppSelection()
            if case .ready(let selection, let catalog) = result {
                applyCatalog(catalog)
                applySelection(selection)
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

    func toggleCategoryExpansion(with id: UUID) {
        if expandedCategoryIDs.contains(id) {
            expandedCategoryIDs.remove(id)
        } else {
            expandedCategoryIDs.insert(id)
        }

        render(animatingDifferences: true)
    }

    func toggleAppSelection(
        categoryID: UUID,
        appID: UUID
    ) {
        guard let categoryIndex = categories.firstIndex(where: { $0.id == categoryID }) else { return }
        guard let appIndex = categories[categoryIndex].appRows.firstIndex(where: { $0.id == appID }) else { return }

        categories[categoryIndex].appRows[appIndex].isSelected.toggle()
        persistSelectionAndRender()
    }

    func render(
        isInitial: Bool = false,
        animatingDifferences: Bool
    ) {
        let categories = makeCategorySectionInputs()
        let sections = factory.makeCollectionContent(categories: categories)

        view?.setContinueEnabled(hasSelectedApps)

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

    func makeCategorySectionInputs() -> [AppSelectionCategorySectionInput] {
        categories.map { category in
            let selectedCount = category.appRows.filter(\.isSelected).count

            return .init(
                id: category.id,
                iconSystemName: category.iconSystemName,
                title: category.title,
                selectedCount: selectedCount,
                isExpanded: expandedCategoryIDs.contains(category.id),
                appRows: category.appRows.map { app in
                    AppSelectionAppRowSectionInput(
                        id: app.id,
                        iconSystemName: app.iconSystemName,
                        title: app.title,
                        isSelected: app.isSelected,
                        onTap: { [weak self] in
                            self?.toggleAppSelection(categoryID: category.id, appID: app.id)
                        }
                    )
                },
                onTap: { [weak self] in
                    self?.toggleCategoryExpansion(with: category.id)
                }
            )
        }
    }

    var hasSelectedApps: Bool {
        categories
            .flatMap(\.appRows)
            .contains(where: \.isSelected)
    }

    func makeSelectionPayload() -> GroupCreationSelectionPayload {
        let selectedAppIDs = categories
            .flatMap(\.appRows)
            .filter(\.isSelected)
            .map(\.id)
        return GroupCreationSelectionPayload(selectedAppIDs: selectedAppIDs)
    }

    func persistSelectionAndRender() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let payload = makeSelectionPayload()
            _ = await useCases.updateSelection(selection: payload)
            render(animatingDifferences: true)
        }
    }

    func applySelection(_ selection: GroupCreationSelectionPayload) {
        let selectedIDs = Set(selection.selectedAppIDs)
        for categoryIndex in categories.indices {
            for appIndex in categories[categoryIndex].appRows.indices {
                let appID = categories[categoryIndex].appRows[appIndex].id
                categories[categoryIndex].appRows[appIndex].isSelected = selectedIDs.contains(appID)
            }
        }
    }

    func applyCatalog(_ catalog: [AppSelectionCatalogCategory]) {
        categories = catalog.map { category in
            CategoryState(
                id: category.id,
                iconSystemName: category.iconSystemName,
                title: category.title,
                appRows: category.apps.map { app in
                    AppState(
                        id: app.id,
                        iconSystemName: app.iconSystemName,
                        title: app.title,
                        isSelected: false
                    )
                }
            )
        }

        if expandedCategoryIDs.isEmpty, let firstCategoryID = categories.first?.id {
            expandedCategoryIDs = [firstCategoryID]
        }
    }
}
