//
//  ModuleFactory+GroupInsight.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

extension ModuleFactory {
    func createGroupInsight(delegate: GroupInsightModuleDelegate?) -> GroupInsightViewController {
        let viewController = GroupInsightViewController()
        let factory = GroupInsightFactory()
        let presenter = GroupInsightPresenter(
            view: viewController,
            factory: factory,
            useCases: appServices.groupInsightUseCases,
            delegate: delegate
        )

        viewController.presenter = presenter
        return viewController
    }
}
