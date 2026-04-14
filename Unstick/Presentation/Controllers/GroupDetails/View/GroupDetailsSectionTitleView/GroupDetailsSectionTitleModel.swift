//
//  GroupDetailsSectionTitleModel.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

nonisolated struct GroupDetailsSectionTitleModel: BaseCellViewModel, Sendable {
    let title: String

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<GroupDetailsSectionTitleView>.self)
    }
}

