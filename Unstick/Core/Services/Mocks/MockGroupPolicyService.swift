//
//  MockGroupPolicyService.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Mock-реализация применения ограничений.
final class MockGroupPolicyService: IGroupPolicyService {
    private let shouldFailApply: (RestrictionGroup) -> Bool

    init(shouldFailApply: @escaping (RestrictionGroup) -> Bool = { _ in false }) {
        self.shouldFailApply = shouldFailApply
    }

    func applyPolicy(group: RestrictionGroup) async throws {
        guard !shouldFailApply(group) else {
            throw PolicyApplyError.applyFailed
        }
    }

    func pausePolicy(groupId: UUID) async throws {}

    func activatePolicy(groupId: UUID) async throws {}

    func clearPolicy(groupId: UUID) async throws {}
}
