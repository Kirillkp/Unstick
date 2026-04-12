//
//  AppServices.swift
//  Unstick
//
//  Created by Codex on 02.04.2026.
//

import Foundation

protocol AppServicing: AnyObject {
    var userDefaultsService: UserDefaultsServicing { get }
    var loadMainScreenUseCase: ILoadMainScreenUseCase { get }
    var openSettingsForAccessUseCase: IOpenSettingsForAccessUseCase { get }

    func shouldShowOnboarding() -> Bool
    func completeOnboarding()
}

final class AppServices: AppServicing {

    let userDefaultsService: UserDefaultsServicing
    let loadMainScreenUseCase: ILoadMainScreenUseCase
    let openSettingsForAccessUseCase: IOpenSettingsForAccessUseCase

    init(userDefaultsService: UserDefaultsServicing = UserDefaultsService()) {
        self.userDefaultsService = userDefaultsService

        let authorizationService = MockAuthorizationService(
            statusProvider: {
                userDefaultsService.isMockAuthorizationNotAvailable ? .notAvailable : .available
            }
        )
        let groupRepository = MockRestrictionGroupRepository()
        self.loadMainScreenUseCase = LoadMainScreenUseCase(
            authorizationService: authorizationService,
            groupRepository: groupRepository
        )
        self.openSettingsForAccessUseCase = OpenSettingsForAccessUseCase(
            authorizationService: authorizationService
        )
    }

    func shouldShowOnboarding() -> Bool {
        userDefaultsService.isShowOnboarding
    }

    func completeOnboarding() {
        userDefaultsService.isShowOnboarding = false
    }
}
