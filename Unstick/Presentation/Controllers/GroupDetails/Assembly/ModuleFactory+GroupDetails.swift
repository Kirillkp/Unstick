//
//  ModuleFactory+GroupDetails.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit

extension ModuleFactory {
    func createGroupDetails(
        groupId: UUID,
        delegate: GroupDetailsModuleDelegate?
    ) -> GroupDetailsViewController {
        let viewController = GroupDetailsViewController()
        let factory = GroupDetailsFactory()
        let presenter = GroupDetailsPresenter(
            view: viewController,
            factory: factory,
            useCases: appServices.groupDetailsUseCases,
            groupId: groupId,
            delegate: delegate
        )

        viewController.presenter = presenter
        return viewController
    }
}
