//
//  StatisticsProtocols.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit

protocol StatisticsPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
}

protocol StatisticsFactoryProtocol: AnyObject {
    func makeCollectionContent(for state: StatisticsViewState.Filled) -> [AnyCollectionSection]
}

protocol StatisticsViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func display(state: StatisticsViewState)
    func refreshCollectionLayout()
}
