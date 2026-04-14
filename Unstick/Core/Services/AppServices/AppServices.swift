//
//  AppServices.swift
//  Unstick
//
//  Created by Codex on 02.04.2026.
//

import Foundation

protocol AppServicing: AnyObject {
    var userDefaultsService: UserDefaultsServicing { get }
    var mainUseCases: IMainUseCases { get }
    var groupInsightUseCases: IGroupInsightUseCases { get }
    var appSelectionUseCases: IAppSelectionUseCases { get }
    var restrictionSetupUseCases: IRestrictionSetupUseCases { get }
    var groupDetailsUseCases: IGroupDetailsUseCases { get }

    func shouldShowOnboarding() -> Bool
    func completeOnboarding()
}

final class AppServices: AppServicing {

    /// Доступ к user defaults и debug-флагам приложения.
    let userDefaultsService: UserDefaultsServicing
    /// Use cases главного экрана: загрузка состояния и переход в Settings.
    let mainUseCases: IMainUseCases
    /// Use cases экрана GroupInsight: загрузка аналитики и старт create-group flow.
    let groupInsightUseCases: IGroupInsightUseCases
    /// Use cases экрана AppSelection: загрузка, сохранение и валидация selection.
    let appSelectionUseCases: IAppSelectionUseCases
    /// Use cases экрана RestrictionSetup: загрузка, валидация и создание группы.
    let restrictionSetupUseCases: IRestrictionSetupUseCases
    /// Use cases экрана GroupDetails: загрузка и действия pause/resume/delete.
    let groupDetailsUseCases: IGroupDetailsUseCases

    init(userDefaultsService: UserDefaultsServicing = UserDefaultsService()) {
        self.userDefaultsService = userDefaultsService

        let authorizationService = MockAuthorizationService(
            statusProvider: {
                userDefaultsService.isMockAuthorizationNotAvailable ? .notAvailable : .available
            }
        )
        let groupRepository = MockRestrictionGroupRepository()
        let groupCreationSessionStore = MockGroupCreationSessionStore()
        let appSelectionCatalogService = MockAppSelectionCatalogService()
        let usageInsightsService = MockUsageInsightsService()
        let groupPolicyService = MockGroupPolicyService()

        self.mainUseCases = MainUseCases(
            authorizationService: authorizationService,
            groupRepository: groupRepository
        )
        self.groupInsightUseCases = GroupInsightUseCases(
            authorizationService: authorizationService,
            usageInsightsService: usageInsightsService,
            sessionStore: groupCreationSessionStore
        )
        self.appSelectionUseCases = AppSelectionUseCases(
            sessionStore: groupCreationSessionStore,
            catalogService: appSelectionCatalogService
        )
        self.restrictionSetupUseCases = RestrictionSetupUseCases(
            authorizationService: authorizationService,
            groupRepository: groupRepository,
            sessionStore: groupCreationSessionStore,
            groupPolicyService: groupPolicyService
        )
        self.groupDetailsUseCases = GroupDetailsUseCases(
            authorizationService: authorizationService,
            groupRepository: groupRepository,
            groupPolicyService: groupPolicyService,
            catalogService: appSelectionCatalogService
        )
    }

    func shouldShowOnboarding() -> Bool {
        userDefaultsService.isShowOnboarding
    }

    func completeOnboarding() {
        userDefaultsService.isShowOnboarding = false
    }
}
