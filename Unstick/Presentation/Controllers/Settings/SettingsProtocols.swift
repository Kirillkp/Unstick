//
//  SettingsProtocols.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//
//

import UIKit

protocol SettingsPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
}

protocol SettingsFactoryProtocol: AnyObject {
    func makeFilledState() -> SettingsViewState.Filled
    func makeCollectionContent(for state: SettingsViewState.Filled) -> [AnyCollectionSection]
}

protocol SettingsViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func display(state: SettingsViewState)
    func refreshCollectionLayout()
}
