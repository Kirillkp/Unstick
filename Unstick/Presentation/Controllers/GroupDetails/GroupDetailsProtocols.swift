//
//  GroupDetailsProtocols.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit

protocol GroupDetailsPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
}

protocol GroupDetailsFactoryProtocol: AnyObject {
    var onDidTapStatusAction: (() -> Void)? { get set }
    var onDidTapDeleteAction: (() -> Void)? { get set }

    func makeCollectionContent(
        input: GroupDetailsSectionInput
    ) -> [AnyCollectionSection]
}

protocol GroupDetailsViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func refreshCollectionLayout()
}
