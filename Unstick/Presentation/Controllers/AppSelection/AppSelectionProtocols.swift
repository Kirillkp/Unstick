//
//  AppSelectionProtocols.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit
import FamilyControls

protocol AppSelectionPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func didTapSelectApps()
    func didUpdatePickerSelection(_ selection: FamilyActivitySelection)
    func didTapContinue()
}

protocol AppSelectionFactoryProtocol: AnyObject {
    func makeCollectionContent(
        summary: SelectionSummary
    ) -> [AnyCollectionSection]
}

protocol AppSelectionViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func setContinueEnabled(_ isEnabled: Bool)
    func refreshCollectionLayout()
    func setSelectAppsActionEnabled(_ isEnabled: Bool)
    func presentFamilyActivityPicker(
        selection: FamilyActivitySelection,
        onSelectionUpdated: @escaping (FamilyActivitySelection) -> Void
    )
}
