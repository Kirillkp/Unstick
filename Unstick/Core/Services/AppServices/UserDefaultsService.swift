//
//  UserDefaultsService.swift
//  Unstick
//
//  Created by Codex on 02.04.2026.
//

import Foundation

protocol UserDefaultsServicing: AnyObject {
    var isShowOnboarding: Bool { get set }
    var isMockAuthorizationNotAvailable: Bool { get set }
}

final class UserDefaultsService: UserDefaultsServicing {

    private enum Keys {
        static let isShowOnboarding = "user_defaults.is_show_onboarding"
        static let isMockAuthorizationNotAvailable = "debug.mock.authorization_not_available"
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    var isShowOnboarding: Bool {
        get {
            guard userDefaults.object(forKey: Keys.isShowOnboarding) != nil else {
                return true
            }

            return userDefaults.bool(forKey: Keys.isShowOnboarding)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isShowOnboarding)
        }
    }

    var isMockAuthorizationNotAvailable: Bool {
        get {
            userDefaults.bool(forKey: Keys.isMockAuthorizationNotAvailable)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isMockAuthorizationNotAvailable)
        }
    }
}
