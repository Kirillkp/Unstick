//
//  SettingsViewState.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import Foundation

enum SettingsViewState {
    case filled(Filled)

    struct Filled {
        let sections: [SettingsCardModel]
    }
}
