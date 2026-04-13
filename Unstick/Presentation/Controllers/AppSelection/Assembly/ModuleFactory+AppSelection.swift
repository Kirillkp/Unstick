//
//  ModuleFactory+AppSelection.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit

extension ModuleFactory {
    func createAppSelection(delegate: AppSelectionModuleDelegate?) -> AppSelectionViewController {
        let viewController = AppSelectionViewController()
        let factory = AppSelectionFactory()
        let presenter = AppSelectionPresenter(
            view: viewController,
            factory: factory,
            useCases: appServices.appSelectionUseCases,
            delegate: delegate
        )

        viewController.presenter = presenter
        return viewController
    }
}
