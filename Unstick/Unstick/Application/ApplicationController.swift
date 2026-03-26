//
//  ApplicationController.swift
//  Movie
//
//  Created by Кирилл Полосов on 15.09.2022.
//

import UIKit

final class ApplicationController {
    
    private let window: UIWindow
    private let navigationController: UINavigationController
    private var tabBarCoordinator: TabBarCoordinator?
    
    init(
        window: UIWindow,
        navigationController: UINavigationController
    ) {
        self.window = window
        self.navigationController = navigationController
    }
    
    /// Стартовая настройка приложения
    func initialSetup() {
        loadMainViewController()
    }
    
    private func loadMainViewController() {
        let tabBarViewController = ModuleFactory.createTabBarModule()
        window.rootViewController = tabBarViewController
        window.makeKeyAndVisible()
        tabBarCoordinator = TabBarCoordinator(
            router: Router(rootController: navigationController),
            tabBarController: tabBarViewController
        )
        
        
        tabBarCoordinator?.start()
    }
}
