//
//  MainCoordinator.swift
//  Movie
//
//  Created by Кирилл Полосов on 18.09.2022.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    
    private let moduleFactory: ModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private let router: Routable
    
    init(
        router: Routable,
        moduleFactory: ModuleFactory,
        coordinatorFactory: CoordinatorFactory
    ) {
        
        self.router = router
        self.moduleFactory = moduleFactory
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
        let module = moduleFactory.createMain(delegate: self)
        router.push(module)
    }
}

extension MainCoordinator: MainModuleDelegate {
    func showNextAction() {
        let coordinator = coordinatorFactory.makeGroupInsightCoordinator(router: router)
        
        coordinator.onFinish = { [weak self] coordinator in
            self?.remove(child: coordinator)
        }

        add(child: coordinator)
        coordinator.start()
    }
}
