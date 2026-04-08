//
//  MainViewState.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import Foundation

enum MainViewState {
    case empty(MainEmptyStateModel)
    case filled(Filled)

    struct Filled {
        let indicatorState: IndicatorView.State
        let actionTitle: String
    }
}
