//
//  CoordinatorFactory+Statistics.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit

extension CoordinatorFactory {
    func makeStatisticsCoordinator() -> CoordinatorGroup<StatisticsCoordinator> {
        let navigation = UINavigationController()
        let router = Router(rootController: navigation)
        let coordinator = StatisticsCoordinator(
            router: router,
            moduleFactory: moduleFactory
        )

        return (coordinator, navigation)
    }
}
