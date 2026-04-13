//
//  ModuleFactory+Main.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import UIKit

extension ModuleFactory {
    func createMain(delegate: MainModuleDelegate?) -> MainViewController {
        let viewController = MainViewController()
        let factory = MainFactory()
        let presenter = MainPresenter(
            view: viewController,
            factory: factory,
            useCases: appServices.mainUseCases,
            delegate: delegate
        )
        viewController.presenter = presenter
        return viewController
    }
}
