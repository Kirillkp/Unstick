//
//  AppSelectionViewState.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

enum AppSelectionViewState {
    case filled(
        hero: HeroSectionModel,
        categories: [AppSelectionCategoryCardModel],
        continueTitle: String,
        isContinueEnabled: Bool
    )
}
