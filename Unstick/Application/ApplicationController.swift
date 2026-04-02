//
//  ApplicationController.swift
//  Movie
//
//  Created by Кирилл Полосов on 15.09.2022.
//

import UIKit

final class ApplicationController {
    
    private let window: UIWindow
    private let appServices: AppServicing
    private let moduleFactory: ModuleFactory
    private let coordinatorFactory: CoordinatorFactory
    private var tabBarCoordinator: TabBarCoordinator?
    
    init(
        window: UIWindow,
        appServices: AppServicing = AppServices()
    ) {
        self.window = window
        self.appServices = appServices
        self.moduleFactory = ModuleFactory(appServices: appServices)
        self.coordinatorFactory = CoordinatorFactory(moduleFactory: moduleFactory)
    }
    
    /// Стартовая настройка приложения
    func initialSetup() {
        if appServices.shouldShowOnboarding() {
            loadOnboardingViewController()
        } else {
            loadMainViewController()
        }
    }
    
    private func loadOnboardingViewController() {
        let onboardingViewController = moduleFactory.createOnboarding(delegate: self)
        window.rootViewController = onboardingViewController
        window.makeKeyAndVisible()
    }

    private func loadMainViewController() {
        let tabBarViewController = moduleFactory.createTabBarModule()
        window.rootViewController = tabBarViewController
        window.makeKeyAndVisible()
        tabBarCoordinator = TabBarCoordinator(
            coordinatorFactory: coordinatorFactory,
            tabBarController: tabBarViewController
        )

        tabBarCoordinator?.start()
    }
}

extension ApplicationController: OnboardingModuleDelegate {
    func onboardingDidFinish() {
        loadMainViewController()
    }
}
