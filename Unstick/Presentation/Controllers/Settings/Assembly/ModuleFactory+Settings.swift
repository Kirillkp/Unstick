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
        let presenter = SettingsPresenter(
            view: viewController,
            delegate: delegate
        )
        viewController.presenter = presenter
        return viewController
    }
}
