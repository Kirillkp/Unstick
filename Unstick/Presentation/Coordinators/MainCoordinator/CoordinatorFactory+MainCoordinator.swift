//
//  CoordinatorFactory+MainCoordinator.swift
//  Movie
//
//  Created by Кирилл Полосов on 19.09.2022.
//

import UIKit

extension CoordinatorFactory {
    func makeMainCoordinator() -> CoordinatorGroup<MainCoordinator> {
        let navigation = UINavigationController()
        let router = Router(rootController: navigation)
        let coordinator = MainCoordinator(
            router: router,
            moduleFactory: moduleFactory,
            coordinatorFactory: self
        )
        return (coordinator, navigation)
    }
}
