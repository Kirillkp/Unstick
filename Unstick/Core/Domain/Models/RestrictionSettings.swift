//
//  RestrictionSettings.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

struct RestrictionSettings: Codable, Equatable {
    var groupName: String
    var dailyLimitMinutes: Int
    var breakSettings: BreakSettings
    var onDemandSettings: OnDemandSettings
}

extension RestrictionSettings {
    struct BreakSettings: Codable, Equatable {
        var isEnabled: Bool
        var remindEveryMinutes: Int
        var durationMinutes: Int
    }

    struct OnDemandSettings: Codable, Equatable {
        var isEnabled: Bool
        var extraMinutes: Int
    }
}
