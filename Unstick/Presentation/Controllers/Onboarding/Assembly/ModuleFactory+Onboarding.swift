//
//  ModuleFactory+Onboarding.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 30.03.2026
//  
//

import UIKit

extension ModuleFactory {
    func createOnboarding(delegate: OnboardingModuleDelegate?) -> OnboardingViewController {
        let viewController = OnboardingViewController()
        let presenter = OnboardingPresenter(
            view: viewController,
            delegate: delegate
        )
        viewController.presenter = presenter
        return viewController
    }
}
