//
//  CoordinatorFactory+GroupInsightCoordinator.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

extension CoordinatorFactory {
    func makeGroupInsightCoordinator(router: Routable) -> GroupInsightCoordinator {
        GroupInsightCoordinator(
            router: router,
            moduleFactory: moduleFactory
        )
    }
}
