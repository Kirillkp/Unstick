//
//  MainViewState.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import Foundation

enum MainViewState {
    case empty(Empty)
    case noAccess(Empty)
    case filled(Filled)

    struct Empty {
        let indicatorState: IndicatorView.State
        let emptyView: MainEmptyStateModel
    }
    
    struct Filled {
        let indicatorState: IndicatorView.State
        let actionTitle: String
    }
}
