//
//  GroupInsightProtocols.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

protocol GroupInsightPresenterProtocol: AnyObject {
    func viewLoaded()
    func viewWillAppear(_ animated: Bool)
    func viewDidAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    func didTapPrimaryAction()
}

protocol GroupInsightFactoryProtocol: AnyObject {
    var onDidTapPrimaryAction: (() -> Void)? { get set }

    func makeCollectionContent(
        activityItems: [GroupInsightActivityItem],
        topApps: [UsageApp]
    ) -> [AnyCollectionSection]
}

protocol GroupInsightViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func refreshCollectionLayout()
}
