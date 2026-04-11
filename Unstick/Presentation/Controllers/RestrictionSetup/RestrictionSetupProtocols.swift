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
        hero: HeroSectionModel,
        groupName: RestrictionSetupGroupNameCardModel,
        dailyLimit: RestrictionSetupDailyLimitCardModel,
        breakSettings: RestrictionSetupBreakCardModel,
        onDemand: RestrictionSetupOnDemandCardModel
    ) -> [AnyCollectionSection]
}

protocol RestrictionSetupViewProtocol: AnyObject {
    var _collectionView: UICollectionView { get }

    func display(state: RestrictionSetupViewState)
    func refreshCollectionLayout()
}
