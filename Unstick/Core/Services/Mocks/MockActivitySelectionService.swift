//
//  MockActivitySelectionService.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import FamilyControls
import Foundation

/// Mock-реализация `FamilyActivitySelection` для изолированной от Apple runtime разработки.
actor MockActivitySelectionService: IActivitySelectionService {
    private var selection: FamilyActivitySelection

    init(initialSelection: FamilyActivitySelection = .init()) {
        self.selection = initialSelection
    }

    func currentSelection() async throws -> FamilyActivitySelection {
        selection
    }

    func setSelection(_ selection: FamilyActivitySelection) async throws {
        self.selection = selection
    }

    func selectionSummary(_ selection: FamilyActivitySelection) -> SelectionSummary {
        SelectionSummary(
            selectedApplicationsCount: selection.applicationTokens.count,
            selectedCategoriesCount: selection.categoryTokens.count,
            selectedWebDomainsCount: selection.webDomainTokens.count
        )
    }
}
