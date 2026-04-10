//
//  HeroSectionModel.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import Foundation

nonisolated struct HeroSectionModel: BaseCellViewModel, Sendable {
    let id: UUID
    let badge: String?
    let title: String
    let highlightedTexts: [String]
    let subtitle: String

    init(
        id: UUID = UUID(),
        badge: String? = nil,
        title: String,
        highlightedTexts: [String] = [],
        subtitle: String
    ) {
        self.id = id
        self.badge = badge
        self.title = title
        self.highlightedTexts = highlightedTexts
        self.subtitle = subtitle
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<HeroSectionView>.self)
    }

    nonisolated static func == (
        lhs: HeroSectionModel,
        rhs: HeroSectionModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
