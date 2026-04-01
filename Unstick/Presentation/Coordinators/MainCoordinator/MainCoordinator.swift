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
    private let isShowOnboarding: Bool = true
    
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
        showOnboarding()
    }
    
    private func showMainModule() {
        let module = moduleFactory.createMain(delegate: self)
        router.push(module)
    }
    
    private func showOnboarding() {
        let module = moduleFactory.createOnboarding(delegate: nil)
        router.push(module)
    }
}

extension MainCoordinator: MainModuleDelegate {
    func showNextAction() {}
}
