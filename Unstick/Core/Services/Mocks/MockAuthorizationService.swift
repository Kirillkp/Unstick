//
//  MockAuthorizationService.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation
import UIKit

/// Mock-реализация сервиса доступа.
final class MockAuthorizationService: IAuthorizationService {
    private let statusProvider: () -> AuthorizationStatus

    init(statusProvider: @escaping () -> AuthorizationStatus = { .available }) {
        self.statusProvider = statusProvider
    }

    func authorizationStatus() async -> AuthorizationStatus {
        statusProvider()
    }

    func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
