//
//  StatisticsCoordinator.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import Foundation

final class StatisticsCoordinator: BaseCoordinator {
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
        showStatistics()
    }

    func showStatistics() {
        let module = moduleFactory.createStatistics(delegate: nil)
        router.push(module)
    }
}
