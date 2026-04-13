//
//  MainUseCases.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Объединенный контракт use cases главного экрана.
protocol IMainUseCases {
    /// Загружает состояние Main с учетом доступа и групп пользователя.
    func loadMainScreen() async -> LoadMainScreenResult
    /// Открывает системные настройки для выдачи доступа.
    func openSettingsForAccess()
}

/// Реализация use cases главного экрана.
final class MainUseCases: IMainUseCases {
    private let authorizationService: IAuthorizationService
    private let groupRepository: IRestrictionGroupRepository

    init(
        authorizationService: IAuthorizationService,
        groupRepository: IRestrictionGroupRepository
    ) {
        self.authorizationService = authorizationService
        self.groupRepository = groupRepository
    }

    func loadMainScreen() async -> LoadMainScreenResult {
        let status = await authorizationService.authorizationStatus()
        let groups = (try? await groupRepository.fetchAll()) ?? []

        switch status {
        case .notAvailable:
            return .noAccess
        case .available:
            return groups.isEmpty ? .empty : .filled(groups: groups)
        }
    }

    func openSettingsForAccess() {
        authorizationService.openSystemSettings()
    }
}
