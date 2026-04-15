//
//  MainProtocols.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import UIKit

// VIEW -> PRESENTER

protocol MainPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func sceneDidBecomeActive()
    func nextAction()
}

// FACTORY -> PRESENTER

protocol MainFactoryProtocol: AnyObject {
    var onDidTapActionButton: (() -> Void)? { get set }

    func makeEmptyCollectionContent(
        indicatorState: IndicatorView.State,
        emptyState: MainEmptyStateModel
    ) -> [AnyCollectionSection]

    func makeFilledCollectionContent(
        indicatorState: IndicatorView.State,
        items: [UsageSummaryCardModel],
        sectionHeader: MainGroupsSectionHeaderModel,
        actionButtonTitle: String
    ) -> [AnyCollectionSection]
}

// PRESENTER -> VIEW

protocol MainViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func setCollectionHidden(_ isHidden: Bool)
    func refreshCollectionLayout()
}
