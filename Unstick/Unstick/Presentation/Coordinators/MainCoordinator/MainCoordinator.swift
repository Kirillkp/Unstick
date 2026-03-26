//
//  MainCoordinator.swift
//  Movie
//
//  Created by Кирилл Полосов on 18.09.2022.
//

import Foundation

final class MainCoordinator: BaseCoordinator {
    
    private let moduleFactory: ModuleFactory
    private let router: Routable
    private let coordinatorFactory: CoordinatorFactory
    
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
        let module = moduleFactory.createMain(delegate: nil)
        router.push(module)
    }
}
