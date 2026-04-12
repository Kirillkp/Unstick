//
//  LoadMainScreenUseCase.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Результат загрузки главного экрана.
enum LoadMainScreenResult {
    /// Нет доступа к системным ограничениям.
    case noAccess
    /// Доступ есть, но у пользователя еще нет групп.
    case empty
    /// Доступ есть и группы присутствуют.
    case filled(groups: [RestrictionGroup])
}

/// Интерфейс use case загрузки состояния главного экрана.
protocol ILoadMainScreenUseCase {
    func execute() async -> LoadMainScreenResult
}

/// Реализация use case загрузки состояния главного экрана.
final class LoadMainScreenUseCase: ILoadMainScreenUseCase {
    private let authorizationService: IAuthorizationService
    private let groupRepository: IRestrictionGroupRepository

    init(
        authorizationService: IAuthorizationService,
        groupRepository: IRestrictionGroupRepository
    ) {
        self.authorizationService = authorizationService
        self.groupRepository = groupRepository
    }

    func execute() async -> LoadMainScreenResult {
        let status = await authorizationService.authorizationStatus()
        let groups = (try? await groupRepository.fetchAll()) ?? []

        switch status {
        case .notAvailable:
            return .noAccess
        case .available:
            return groups.isEmpty ? .empty : .filled(groups: groups)
        }
    }
}
