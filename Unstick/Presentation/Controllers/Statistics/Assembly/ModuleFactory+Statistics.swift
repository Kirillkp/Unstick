//
//  ModuleFactory+Statistics.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit

extension ModuleFactory {
    func createStatistics(delegate: StatisticsModuleDelegate?) -> StatisticsViewController {
        let viewController = StatisticsViewController()
        let factory = StatisticsFactory()
        let presenter = StatisticsPresenter(
            view: viewController,
            factory: factory,
            delegate: delegate
        )
        viewController.presenter = presenter
        return viewController
    }
}
