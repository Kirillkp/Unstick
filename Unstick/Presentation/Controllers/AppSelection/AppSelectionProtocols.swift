//
//  AppSelectionProtocols.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

protocol AppSelectionPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func didTapContinue()
}

protocol AppSelectionFactoryProtocol: AnyObject {
    func makeCollectionContent(
        hero: HeroSectionModel,
        categories: [AppSelectionCategoryCardModel]
    ) -> [AnyCollectionSection]
}

protocol AppSelectionViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func display(state: AppSelectionViewState)
    func refreshCollectionLayout()
}
