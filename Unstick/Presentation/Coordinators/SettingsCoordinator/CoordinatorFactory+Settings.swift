//
//  CoordinatorFactory+Settings.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//  
//

import UIKit

extension CoordinatorFactory {
    func makeSettingsCoordinator() -> CoordinatorGroup<SettingsCoordinator> {
        let navigation = UINavigationController()
        let router = Router(rootController: navigation)
        let coordinator = SettingsCoordinator(
            router: router,
            moduleFactory: moduleFactory
        )

        return (coordinator, navigation)
    }
}
