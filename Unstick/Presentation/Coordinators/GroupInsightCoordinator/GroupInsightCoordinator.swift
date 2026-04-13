//
//  GroupInsightCoordinator.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation
import UIKit

final class GroupInsightCoordinator: BaseCoordinator {
    private let router: Routable
    private let moduleFactory: ModuleFactory

    init(
        router: Routable,
        moduleFactory: ModuleFactory
    ) {
        self.router = router
        self.moduleFactory = moduleFactory
    }

    override func start() {
        showGroupInsight()
    }

    private func showGroupInsight() {
        let module = moduleFactory.createGroupInsight(delegate: self)
        module.hidesBottomBarWhenPushed = true
        router.push(module, animated: true)
    }

    private func runAppSelection() {
        let module = moduleFactory.createAppSelection(delegate: self)
        module.hidesBottomBarWhenPushed = true
        router.push(module, animated: true)
    }

    private func runRestrictionSetup() {
        let module = moduleFactory.createRestrictionSetup(delegate: self)
        module.hidesBottomBarWhenPushed = true
        router.push(module, animated: true)
    }
}

extension GroupInsightCoordinator: GroupInsightModuleDelegate {
    func showAppSelection() {
        runAppSelection()
    }
}

extension GroupInsightCoordinator: AppSelectionModuleDelegate {
    func showRestrictionSetup() {
        runRestrictionSetup()
    }
}

extension GroupInsightCoordinator: RestrictionSetupModuleDelegate {
    func didFinishRestrictionSetup() {
        router.popToRootModule(animated: true)
        onFinish?(self)
    }
}
