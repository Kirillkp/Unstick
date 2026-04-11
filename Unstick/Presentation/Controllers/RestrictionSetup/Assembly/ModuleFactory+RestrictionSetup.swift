//
//  ModuleFactory+RestrictionSetup.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit

extension ModuleFactory {
    func createRestrictionSetup(delegate: RestrictionSetupModuleDelegate?) -> RestrictionSetupViewController {
        let viewController = RestrictionSetupViewController()
        let factory = RestrictionSetupFactory()
        let presenter = RestrictionSetupPresenter(
            view: viewController,
            factory: factory,
            delegate: delegate
        )

        viewController.presenter = presenter
        return viewController
    }
}

