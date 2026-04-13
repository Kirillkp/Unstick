//
//  RestrictionSetupProtocols.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit

protocol RestrictionSetupPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func didTapContinue()
}

protocol RestrictionSetupFactoryProtocol: AnyObject {
    func makeCollectionContent(
        input: RestrictionSetupSectionInput
    ) -> [AnyCollectionSection]
}

protocol RestrictionSetupViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func setContinueEnabled(_ isEnabled: Bool)
    func refreshCollectionLayout()
}
