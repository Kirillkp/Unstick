//
//  OpenSettingsForAccessUseCase.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Интерфейс use case открытия настроек доступа.
protocol IOpenSettingsForAccessUseCase {
    func execute()
}

/// Реализация use case открытия системных настроек приложения.
final class OpenSettingsForAccessUseCase: IOpenSettingsForAccessUseCase {
    private let authorizationService: IAuthorizationService

    init(authorizationService: IAuthorizationService) {
        self.authorizationService = authorizationService
    }

    func execute() {
        authorizationService.openSystemSettings()
    }
}
