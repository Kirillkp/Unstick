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
    var isUseAppleAuthorizationService: Bool { get set }
    var isUseAppleActivitySelectionService: Bool { get set }
    var isUseAppleGroupPolicyService: Bool { get set }
    var restrictionGroupsData: Data? { get set }
}

final class UserDefaultsService: UserDefaultsServicing {

    private enum Keys {
        static let isShowOnboarding = "user_defaults.is_show_onboarding"
        static let isMockAuthorizationNotAvailable = "debug.mock.authorization_not_available"
        static let isUseAppleAuthorizationService = "debug.apple.use_authorization_service"
        static let isUseAppleActivitySelectionService = "debug.apple.use_activity_selection_service"
        static let isUseAppleGroupPolicyService = "debug.apple.use_group_policy_service"
        static let restrictionGroupsData = "storage.restriction_groups_data"
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

    var isUseAppleAuthorizationService: Bool {
        get {
            userDefaults.bool(forKey: Keys.isUseAppleAuthorizationService)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isUseAppleAuthorizationService)
        }
    }

    var isUseAppleActivitySelectionService: Bool {
        get {
            userDefaults.bool(forKey: Keys.isUseAppleActivitySelectionService)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isUseAppleActivitySelectionService)
        }
    }

    var isUseAppleGroupPolicyService: Bool {
        get {
            userDefaults.bool(forKey: Keys.isUseAppleGroupPolicyService)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.isUseAppleGroupPolicyService)
        }
    }

    var restrictionGroupsData: Data? {
        get {
            userDefaults.data(forKey: Keys.restrictionGroupsData)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.restrictionGroupsData)
        }
    }
}
