//
//  AppleAuthorizationService.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import FamilyControls
import Foundation
import UIKit

/// Реальная реализация сервиса авторизации Screen Time / FamilyControls.
final class AppleAuthorizationService: IAuthorizationService {
    func authorizationStatus() async -> AuthorizationStatus {
        switch AuthorizationCenter.shared.authorizationStatus {
        case .approved:
            return .available
        case .notDetermined, .denied:
            return .notAvailable
        @unknown default:
            return .notAvailable
        }
    }

    func openSystemSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
