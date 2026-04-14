//
//  GroupDetailsUseCases.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

/// Модель строки приложения для блока "Приложения в группе" на экране деталки.
struct GroupDetailsAppRow: Sendable {
    let id: UUID
    let title: String
    let iconSystemName: String
}

/// Результат загрузки данных для экрана GroupDetails.
enum LoadGroupDetailsResult {
    /// Группа по идентификатору не найдена.
    case notFound
    /// Группа найдена и подготовлены данные для отображения.
    case ready(group: RestrictionGroup, appRows: [GroupDetailsAppRow])
}

/// Контракт use cases экрана GroupDetails.
/// Отвечает за чтение деталки и действия пользователя над группой.
protocol IGroupDetailsUseCases {
    /// Загружает группу и связанные данные приложений для отображения на экране.
    func loadGroupDetails(groupId: UUID) async -> LoadGroupDetailsResult
    /// Обновляет настройки группы и пере-применяет policy для активной группы.
    func updateGroupSettings(groupId: UUID, settings: RestrictionSettings) async throws
    /// Переводит группу в статус `paused` и приостанавливает ограничения.
    func pauseGroup(groupId: UUID) async throws
    /// Переводит группу в статус `active` и снова активирует ограничения.
    func resumeGroup(groupId: UUID) async throws
    /// Удаляет группу и очищает policy (best effort).
    func deleteGroup(groupId: UUID) async throws
}

/// Реализация бизнес-логики экрана GroupDetails.
final class GroupDetailsUseCases: IGroupDetailsUseCases {
    private let authorizationService: IAuthorizationService
    private let groupRepository: IRestrictionGroupRepository
    private let groupPolicyService: IGroupPolicyService
    private let catalogService: IAppSelectionCatalogService

    init(
        authorizationService: IAuthorizationService,
        groupRepository: IRestrictionGroupRepository,
        groupPolicyService: IGroupPolicyService,
        catalogService: IAppSelectionCatalogService
    ) {
        self.authorizationService = authorizationService
        self.groupRepository = groupRepository
        self.groupPolicyService = groupPolicyService
        self.catalogService = catalogService
    }

    func loadGroupDetails(groupId: UUID) async -> LoadGroupDetailsResult {
        guard let group = try? await groupRepository.fetch(id: groupId) else {
            return .notFound
        }

        let appRows = await makeAppRows(from: group.selectionData)
        return .ready(group: group, appRows: appRows)
    }

    /// Валидирует и сохраняет обновленные настройки группы.
    /// Для активной группы дополнительно пере-применяет ограничения через policy service.
    func updateGroupSettings(groupId: UUID, settings: RestrictionSettings) async throws {
        let status = await authorizationService.authorizationStatus()
        guard status == .available else {
            throw AccessError.authorizationMissing
        }

        try validate(settings: settings)

        guard var group = try await groupRepository.fetch(id: groupId) else {
            throw StorageError.fetchFailed
        }

        group.settings = settings
        group.updatedAt = Date()

        if group.status == .active {
            try await groupPolicyService.applyPolicy(group: group)
        }

        try await groupRepository.save(group)
    }

    /// Ставит группу на паузу: сначала policy, затем фиксация статуса в репозитории.
    func pauseGroup(groupId: UUID) async throws {
        let status = await authorizationService.authorizationStatus()
        guard status == .available else {
            throw AccessError.authorizationMissing
        }

        try await groupPolicyService.pausePolicy(groupId: groupId)
        try await groupRepository.updateStatus(id: groupId, status: .paused)
    }

    /// Возобновляет группу: активирует policy и сохраняет статус `active`.
    func resumeGroup(groupId: UUID) async throws {
        let status = await authorizationService.authorizationStatus()
        guard status == .available else {
            throw AccessError.authorizationMissing
        }

        try await groupPolicyService.activatePolicy(groupId: groupId)
        try await groupRepository.updateStatus(id: groupId, status: .active)
    }

    /// Удаляет группу из хранилища.
    /// Очистка policy выполняется в best effort режиме и не блокирует удаление.
    func deleteGroup(groupId: UUID) async throws {
        // Best effort policy cleanup: удаление из репозитория не блокируется ошибкой clearPolicy.
        try? await groupPolicyService.clearPolicy(groupId: groupId)
        try await groupRepository.delete(id: groupId)
    }
}

private extension GroupDetailsUseCases {
    func validate(settings: RestrictionSettings) throws {
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

    func makeAppRows(from selectionData: Data) async -> [GroupDetailsAppRow] {
        guard
            let payload = try? JSONDecoder().decode(GroupCreationSelectionPayload.self, from: selectionData),
            !payload.selectedAppIDs.isEmpty
        else {
            return []
        }

        let catalog = (try? await catalogService.fetchCatalog()) ?? []
        let appById = Dictionary(
            uniqueKeysWithValues: catalog
                .flatMap(\.apps)
                .map { ($0.id, $0) }
        )

        return payload.selectedAppIDs.compactMap { id in
            guard let app = appById[id] else { return nil }
            return GroupDetailsAppRow(
                id: app.id,
                title: app.title,
                iconSystemName: app.iconSystemName
            )
        }
    }
}
