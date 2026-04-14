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

    func showGroupDetails(groupId: UUID) {
        let module = moduleFactory.createGroupDetails(
            groupId: groupId,
            delegate: self
        )
        router.push(module)
    }
}

extension MainCoordinator: GroupDetailsModuleDelegate {
    func didFinishGroupDetails() {
        router.popModule(animated: true)
    }
}
