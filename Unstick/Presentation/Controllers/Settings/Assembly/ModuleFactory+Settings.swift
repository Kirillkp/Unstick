//
//  ModuleFactory+Settings.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//  
//

import UIKit

extension ModuleFactory {
    func createSettings(delegate: SettingsModuleDelegate?) -> SettingsViewController {
        let viewController = SettingsViewController()
        let factory = SettingsFactory()
        let presenter = SettingsPresenter(
            view: viewController,
            factory: factory,
            delegate: delegate
        )
        viewController.presenter = presenter
        return viewController
    }
}
