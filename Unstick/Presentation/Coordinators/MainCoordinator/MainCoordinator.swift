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
    
    init(
        router: Routable,
        moduleFactory: ModuleFactory
    ) {
        
        self.router = router
        self.moduleFactory = moduleFactory
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
    func showNextAction() {}
}
