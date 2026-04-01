//
//  TabBarCoordinator.swift
//  Movie
//
//  Created by Кирилл Полосов on 18.09.2022.
//

import Foundation
import UIKit

final class TabBarCoordinator: BaseCoordinator {
    
    private let router: Routable
    private let coordinatorFactory: CoordinatorFactory
    private var tabBarController: TabBarController?
    
    private var mainCoordinator: MainCoordinator?
    private var settingsCoordinator: SettingsCoordinator?
    
    init(
        router: Routable,
        coordinatorFactory: CoordinatorFactory = .init(),
        tabBarController: TabBarController
    ) {
        
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.tabBarController = tabBarController
    }
    
    override func start() {
        bindToTabBarModule()
    }
    
    private func bindToTabBarModule() {
        let modernControllers = TabBarItem.allCases
            .compactMap { makeTabBarItemCoordinator(for: $0).toPresent }

        tabBarController?.setViewControllers(modernControllers, animated: false)
        
        tabBarController?.configureThemeAppearance()
    }
    
    private func makeTabBarItemCoordinator(for item: TabBarItem) -> Presentable {
        let coordinator: Coordinatable
        let presentable: Presentable
        
        switch item {
        case .main:
            let (mainCoordinator, mainPresentable) = coordinatorFactory.makeMainCoordinator()
            
            (coordinator, presentable) = (mainCoordinator, mainPresentable)
            
            self.mainCoordinator = mainCoordinator
        case .settings:
            let (settingsCoordinator, settingsPresentable) = coordinatorFactory.makeSettingsCoordinator()
            
            (coordinator, presentable) = (settingsCoordinator, settingsPresentable)
            
            self.settingsCoordinator = settingsCoordinator
        }
        
        add(child: coordinator)
        coordinator.start()
        
        return presentable
    }
}
