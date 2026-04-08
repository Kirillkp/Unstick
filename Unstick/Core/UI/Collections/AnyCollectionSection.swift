//
//  CollectionSection.swift
//  Unstick
//
//  Created by Codex on 07.04.2026.
//

import Foundation

nonisolated struct AnyCollectionItem: Hashable, @unchecked Sendable {
    let id: AnyHashable
    let viewModel: any BaseCellViewModel

    init<Model: BaseCellViewModel>(
        _ viewModel: Model,
        id: AnyHashable? = nil
    ) {
        self.id = id ?? AnyHashable(viewModel)
        self.viewModel = viewModel
    }

    nonisolated static func == (
        lhs: AnyCollectionItem,
        rhs: AnyCollectionItem
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

nonisolated struct AnyCollectionSupplementaryItem: Hashable, @unchecked Sendable {
    let id: AnyHashable
    let viewModel: any BaseCellViewModel

    init<Model: BaseCellViewModel>(
        _ viewModel: Model,
        id: AnyHashable? = nil
    ) {
        self.id = id ?? AnyHashable(viewModel)
        self.viewModel = viewModel
    }

    var cellIdentifier: String {
        viewModel.cellIdentifier
    }

    nonisolated static func == (
        lhs: AnyCollectionSupplementaryItem,
        rhs: AnyCollectionSupplementaryItem
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

nonisolated struct AnyCollectionSection: Hashable, @unchecked Sendable {
    let id: AnyHashable
    let identifier: String
    let supplementaryItem: AnyCollectionSupplementaryItem?
    let items: [AnyCollectionItem]

    init<ID: Hashable & Sendable>(
        id: ID,
        identifier: String,
        supplementaryItem: AnyCollectionSupplementaryItem? = nil,
        items: [AnyCollectionItem]
    ) {
        self.id = AnyHashable(id)
        self.identifier = identifier
        self.supplementaryItem = supplementaryItem
        self.items = items
    }

    nonisolated static func == (
        lhs: AnyCollectionSection,
        rhs: AnyCollectionSection
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
