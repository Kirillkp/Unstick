//
//  AppSelectionPresenter.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

protocol AppSelectionModuleDelegate: AnyObject {}

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
    private let dataSource: AnyCollectionDataSource

    private var pendingSections: [AnyCollectionSection] = []
    private var isInitialSnapshotApplied = false
    private var expandedCategoryIDs: Set<UUID> = [
        UUID(uuidString: "A81B9E5B-EC4D-430A-A662-6DBA91CD2A12") ?? UUID()
    ]
    private var categories: [CategoryState]

    init(
        view: AppSelectionViewProtocol,
        factory: AppSelectionFactoryProtocol,
        delegate: AppSelectionModuleDelegate?
    ) {
        self.view = view
        self.factory = factory
        self.delegate = delegate
        self.dataSource = AnyCollectionDataSource(collectionView: view._collectionView)
        self.categories = AppSelectionPresenter.makeInitialCategories()
    }
}

extension AppSelectionPresenter: AppSelectionPresenterProtocol {
    func viewLoaded() {
        let hero = makeHeroModel()
        let categories = makeCategoryModels()
        let state = makeViewState(hero: hero, categories: categories)
        pendingSections = factory.makeCollectionContent(
            hero: hero,
            categories: categories
        )
        view?.display(state: state)
    }

    func viewWillAppear(_ animated: Bool) {}

    func viewDidAppear(_ animated: Bool) {
        applyInitialSnapshotIfNeeded()
    }

    func viewWillDisappear(_ animated: Bool) {}

    func didTapContinue() {}
}

private extension AppSelectionPresenter {
    private static func makeInitialCategories() -> [CategoryState] {
        [
            .init(
                id: UUID(uuidString: "A81B9E5B-EC4D-430A-A662-6DBA91CD2A12") ?? UUID(),
                iconSystemName: "point.3.connected.trianglepath.dotted",
                title: "Соцсети",
                appRows: [
                    .init(
                        id: UUID(uuidString: "E4F0E6B0-545A-4F24-B08A-EAFA5E0E4201") ?? UUID(),
                        iconSystemName: "camera.macro",
                        title: "Instagram",
                        isSelected: true
                    ),
                    .init(
                        id: UUID(uuidString: "9D3A1E59-2A79-4BF3-8995-9A1E2116C261") ?? UUID(),
                        iconSystemName: "music.note",
                        title: "TikTok",
                        isSelected: true
                    ),
                    .init(
                        id: UUID(uuidString: "5E1F616B-416E-4E40-973F-1FC4B91A830F") ?? UUID(),
                        iconSystemName: "bubble.left.and.bubble.right",
                        title: "Twitter",
                        isSelected: true
                    )
                ]
            ),
            .init(
                id: UUID(uuidString: "E4BDF9B5-A6E8-4EB1-906B-BE131702E7F1") ?? UUID(),
                iconSystemName: "movieclapper",
                title: "Видео",
                appRows: [
                    .init(
                        id: UUID(uuidString: "7E36E961-14F5-4B3E-98DD-228A8DB39F01") ?? UUID(),
                        iconSystemName: "play.rectangle.fill",
                        title: "YouTube",
                        isSelected: false
                    ),
                    .init(
                        id: UUID(uuidString: "F8B8C159-B0A1-4D6A-964B-4F17AD4CB9D2") ?? UUID(),
                        iconSystemName: "tv.fill",
                        title: "Netflix",
                        isSelected: false
                    ),
                    .init(
                        id: UUID(uuidString: "0B6AF81C-D6D1-42C3-B5CF-77AE086672B8") ?? UUID(),
                        iconSystemName: "play.tv.fill",
                        title: "Twitch",
                        isSelected: false
                    )
                ]
            ),
            .init(
                id: UUID(uuidString: "4E5D7515-362C-43FD-BF58-7AA16FB3D0D6") ?? UUID(),
                iconSystemName: "gamecontroller",
                title: "Игры",
                appRows: [
                    .init(
                        id: UUID(uuidString: "A9C1F87A-1988-45E1-A9F6-4A559DE644E4") ?? UUID(),
                        iconSystemName: "gamecontroller.fill",
                        title: "Mobile Legends",
                        isSelected: false
                    ),
                    .init(
                        id: UUID(uuidString: "6C1A48CB-2789-4662-BD80-C2115C70F0B7") ?? UUID(),
                        iconSystemName: "shield.lefthalf.filled",
                        title: "Rise of Kingdoms",
                        isSelected: false
                    ),
                    .init(
                        id: UUID(uuidString: "D8F8E6F4-26D7-4D88-8A0A-304D2983C722") ?? UUID(),
                        iconSystemName: "dice.fill",
                        title: "Royal Match",
                        isSelected: false
                    )
                ]
            )
        ]
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
        render(animatingDifferences: true)
    }

    func render(animatingDifferences: Bool) {
        let hero = makeHeroModel()
        let categories = makeCategoryModels()
        let state = makeViewState(hero: hero, categories: categories)
        let sections = factory.makeCollectionContent(
            hero: hero,
            categories: categories
        )

        view?.display(state: state)

        guard isInitialSnapshotApplied else {
            pendingSections = sections
            return
        }

        dataSource.setSections(with: sections)
        dataSource.applySnapshot(animatingDifferences: animatingDifferences) { [weak self] in
            self?.view?.refreshCollectionLayout()
        }
    }

    func makeViewState(
        hero: HeroSectionModel,
        categories: [AppSelectionCategoryCardModel]
    ) -> AppSelectionViewState {
        .filled(
            hero: hero,
            categories: categories,
            continueTitle: makeContinueTitle(),
            isContinueEnabled: hasSelectedApps
        )
    }

    func makeHeroModel() -> HeroSectionModel {
        HeroSectionModel(
            title: "Выберите\nприложения",
            subtitle: "Отметьте те, которые больше всего отвлекают вас от важных дел."
        )
    }

    func makeContinueTitle() -> String {
        "Продолжить"
    }

    func makeCategoryModels() -> [AppSelectionCategoryCardModel] {
        categories.map { category in
            let selectedCount = category.appRows.filter(\.isSelected).count

            return .init(
                id: category.id,
                iconSystemName: category.iconSystemName,
                title: category.title,
                subtitle: "\(selectedCount) выбрано",
                isExpanded: expandedCategoryIDs.contains(category.id),
                appRows: category.appRows.map { app in
                    AppSelectionAppRowModel(
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
}
