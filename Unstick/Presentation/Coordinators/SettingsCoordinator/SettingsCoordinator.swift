//
//  SettingsCoordinator.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//  
//

import Foundation

final class SettingsCoordinator: BaseCoordinator {

    private let router: Routable
    private let moduleFactory: ModuleFactory

    init(
        router: Routable,
        moduleFactory: ModuleFactory
    ) {
        self.router = router
        self.moduleFactory = moduleFactory
    }

    override func start() {
        showSettings()
    }

    func showSettings() {
        let module = moduleFactory.createSettings(delegate: nil)
        router.push(module)
    }
}
