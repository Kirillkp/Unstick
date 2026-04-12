//
//  AuthorizationService.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Интерфейс сервиса доступа к системным ограничениям.
/// Используется для чтения статуса доступа и перехода пользователя в настройки.
protocol IAuthorizationService {
    /// Возвращает текущий статус доступа к Screen Time/FamilyControls.
    func authorizationStatus() async -> AuthorizationStatus

    /// Открывает системные настройки приложения для ручной выдачи доступа.
    func openSystemSettings()
}
