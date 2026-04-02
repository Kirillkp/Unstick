//
//  AppServices.swift
//  Unstick
//
//  Created by Codex on 02.04.2026.
//

import Foundation

protocol AppServicing: AnyObject {
    var userDefaultsService: UserDefaultsServicing { get }
    
    func shouldShowOnboarding() -> Bool
    func completeOnboarding()
}

final class AppServices: AppServicing {

    let userDefaultsService: UserDefaultsServicing

    init(userDefaultsService: UserDefaultsServicing = UserDefaultsService()) {
        self.userDefaultsService = userDefaultsService
    }

    func shouldShowOnboarding() -> Bool {
        userDefaultsService.isShowOnboarding
    }

    func completeOnboarding() {
        userDefaultsService.isShowOnboarding = false
    }
}
