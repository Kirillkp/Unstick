//
//  RestrictionSetupUseCases.swift
//  Unstick
//
//  Created by Codex on 13.04.2026.
//

import Foundation

/// Результат загрузки начальных данных для RestrictionSetup.
enum LoadRestrictionSetupResult {
    /// Экран готов с актуальными настройками из create-group сессии.
    case ready(settings: RestrictionSettings)
}

/// Результат выполнения транзакции создания группы.
enum CreateGroupResult {
    /// Группа создана, policy применена, возвращается идентификатор группы.
    case createdActive(groupId: UUID)
}

/// Объединенный контракт use cases экрана RestrictionSetup.
protocol IRestrictionSetupUseCases {
    /// Загружает текущие настройки ограничений для экрана RestrictionSetup.
    func loadRestrictionSetup() async -> LoadRestrictionSetupResult
    /// Обновляет и валидирует настройки ограничений в ходе редактирования формы.
    func updateRestrictionSettings(settings: RestrictionSettings) async throws -> Bool
    /// Создает группу ограничений из данных текущей сессии.
    func createGroup() async throws -> CreateGroupResult
}

/// Реализация use cases экрана RestrictionSetup.
final class RestrictionSetupUseCases: IRestrictionSetupUseCases {
    private let authorizationService: IAuthorizationService
    private let groupRepository: IRestrictionGroupRepository
    private let sessionStore: IGroupCreationSessionStore
    private let groupPolicyService: IGroupPolicyService
    private let transactionGuard = CreateGroupTransactionGuard()

    init(
        authorizationService: IAuthorizationService,
        groupRepository: IRestrictionGroupRepository,
        sessionStore: IGroupCreationSessionStore,
        groupPolicyService: IGroupPolicyService
    ) {
        self.authorizationService = authorizationService
        self.groupRepository = groupRepository
        self.sessionStore = sessionStore
        self.groupPolicyService = groupPolicyService
    }

    func loadRestrictionSetup() async -> LoadRestrictionSetupResult {
        .ready(settings: await sessionStore.settings())
    }

    func updateRestrictionSettings(settings: RestrictionSettings) async throws -> Bool {
        try validate(settings: settings)
        await sessionStore.updateSettings(settings)
        return true
    }

    func createGroup() async throws -> CreateGroupResult {
        try await transactionGuard.begin()
        do {
            let authorizationStatus = await authorizationService.authorizationStatus()
            guard authorizationStatus == .available else {
                throw AccessError.authorizationMissing
            }

            let settings = await sessionStore.settings()
            try validate(settings: settings)

            let selectionPayload = await sessionStore.selection()
            guard !selectionPayload.isEmpty else {
                throw ValidationError.emptySelection
            }
            let selectionData = try JSONEncoder().encode(selectionPayload)

            var group = RestrictionGroup(
                selectionData: selectionData,
                settings: settings,
                status: .active
            )
            group.updatedAt = Date()
            try await groupRepository.save(group)

            do {
                try await groupPolicyService.applyPolicy(group: group)
            } catch {
                // Rollback persisted group to avoid partially-created state
                // when policy application fails.
                try? await groupRepository.delete(id: group.id)
                throw error
            }

            await sessionStore.reset(defaultSettings: GroupCreationDefaults.settings)
            await transactionGuard.end()
            return .createdActive(groupId: group.id)
        } catch {
            await transactionGuard.end()
            throw error
        }
    }

    private func validate(settings: RestrictionSettings) throws {
        if settings.groupName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw ValidationError.groupNameEmpty
        }
        if settings.dailyLimitMinutes <= 0 {
            throw ValidationError.invalidDailyLimit
        }
        if settings.onDemandSettings.isEnabled && settings.onDemandSettings.extraMinutes <= 0 {
            throw ValidationError.invalidOnDemandExtraTime
        }
    }
}

private actor CreateGroupTransactionGuard {
    private var isInFlight = false

    func begin() throws {
        guard !isInFlight else {
            throw PolicyApplyError.inconsistentGroup
        }
        isInFlight = true
    }

    func end() {
        isInFlight = false
    }
}
