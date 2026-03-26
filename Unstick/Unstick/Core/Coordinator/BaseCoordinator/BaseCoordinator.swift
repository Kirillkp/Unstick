//
//  BaseCoordinator.swift
//  CoordinatorLib
//
//  Created by Кирилл Полосов on 17.09.2022.
//

import Foundation

open class BaseCoordinator: Coordinatable {

    public private(set) var childCoordinators: [Coordinatable] = []

    public var onFinish: ((Coordinatable) -> ())?

    public init() {}
    
    open func start() {
        assertionFailure("Method start() has not been implemented")
    }

    public func add(child coordinator: Coordinatable) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    public func remove(child coordinator: Coordinatable?) {
        guard !childCoordinators.isEmpty else {
            return
        }
        guard let coordinator = coordinator else {
            return
        }

        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            return
        }
    }

    open func finishFlow() {
        onFinish?(self)
    }
}
