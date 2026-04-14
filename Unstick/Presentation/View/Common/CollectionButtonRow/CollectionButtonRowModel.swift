//
//  CollectionButtonRowModel.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit

nonisolated struct CollectionButtonRowModel: BaseCellViewModel, @unchecked Sendable {
    let id: UUID
    let title: String
    let image: UIImage?
    let buttonStyle: DS.ButtonStyle
    let buttonSize: DS.ButtonSize
    let isEnabled: Bool
    let onTap: (() -> Void)?

    init(
        id: UUID = UUID(),
        title: String,
        image: UIImage? = nil,
        buttonStyle: DS.ButtonStyle = .secondaryDashed,
        buttonSize: DS.ButtonSize = .xl,
        isEnabled: Bool = true,
        onTap: (() -> Void)? = nil
    ) {
        self.id = id
        self.title = title
        self.image = image
        self.buttonStyle = buttonStyle
        self.buttonSize = buttonSize
        self.isEnabled = isEnabled
        self.onTap = onTap
    }

    var registration: CollectionReusableRegistration {
        .cell(AnyCollectionCell<CollectionButtonRowView>.self)
    }

    nonisolated static func == (
        lhs: CollectionButtonRowModel,
        rhs: CollectionButtonRowModel
    ) -> Bool {
        lhs.id == rhs.id
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
