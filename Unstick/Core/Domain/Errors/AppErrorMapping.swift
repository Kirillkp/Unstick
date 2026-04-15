//
//  AppErrorMapping.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import Foundation

/// Нормализованное представление доменной ошибки для UI-слоя.
struct AppMappedError: Equatable {
    /// Стабильный код ошибки для единообразной обработки и логирования.
    let code: String
    /// Локализуемый ключ заголовка ошибки.
    let titleKey: String
    /// Локализуемый ключ описания ошибки.
    let messageKey: String
    /// Флаг, показывающий, можно ли безопасно предложить повтор операции.
    let isRetryable: Bool
}

/// Единый mapper технических и доменных ошибок в UI-ошибки.
enum AppErrorMapper {
    static func map(_ error: Error) -> AppMappedError {
        if let validation = error as? ValidationError {
            return mapValidation(validation)
        }
        if let storage = error as? StorageError {
            return mapStorage(storage)
        }
        if let access = error as? AccessError {
            return mapAccess(access)
        }
        if let policy = error as? PolicyApplyError {
            return mapPolicy(policy)
        }

        return AppMappedError(
            code: "unknown",
            titleKey: "error.common.title",
            messageKey: "error.common.message",
            isRetryable: true
        )
    }
}

/// Централизованный обработчик mapped-ошибок.
/// Сейчас работает как кодовый обработчик (debug log), позже сюда
/// можно добавить единый UI alert/snackbar pipeline.
enum AppErrorHandler {
    static func handle(
        _ error: Error,
        context: String
    ) {
        let mapped = AppErrorMapper.map(error)
        #if DEBUG
        print("[AppError][\(context)] code=\(mapped.code) title=\(mapped.titleKey) message=\(mapped.messageKey) retryable=\(mapped.isRetryable)")
        #endif
    }
}

private extension AppErrorMapper {
    static func mapValidation(_ error: ValidationError) -> AppMappedError {
        switch error {
        case .groupNameEmpty:
            return AppMappedError(
                code: "validation.group_name_empty",
                titleKey: "error.validation.title",
                messageKey: "error.validation.group_name_empty",
                isRetryable: false
            )
        case .invalidDailyLimit:
            return AppMappedError(
                code: "validation.invalid_daily_limit",
                titleKey: "error.validation.title",
                messageKey: "error.validation.invalid_daily_limit",
                isRetryable: false
            )
        case .invalidOnDemandExtraTime:
            return AppMappedError(
                code: "validation.invalid_on_demand_extra_time",
                titleKey: "error.validation.title",
                messageKey: "error.validation.invalid_on_demand_extra_time",
                isRetryable: false
            )
        case .emptySelection:
            return AppMappedError(
                code: "validation.empty_selection",
                titleKey: "error.validation.title",
                messageKey: "error.validation.empty_selection",
                isRetryable: false
            )
        }
    }

    static func mapStorage(_ error: StorageError) -> AppMappedError {
        switch error {
        case .saveFailed:
            return AppMappedError(
                code: "storage.save_failed",
                titleKey: "error.storage.title",
                messageKey: "error.storage.save_failed",
                isRetryable: true
            )
        case .fetchFailed:
            return AppMappedError(
                code: "storage.fetch_failed",
                titleKey: "error.storage.title",
                messageKey: "error.storage.fetch_failed",
                isRetryable: true
            )
        case .deleteFailed:
            return AppMappedError(
                code: "storage.delete_failed",
                titleKey: "error.storage.title",
                messageKey: "error.storage.delete_failed",
                isRetryable: true
            )
        }
    }

    static func mapAccess(_ error: AccessError) -> AppMappedError {
        switch error {
        case .authorizationMissing:
            return AppMappedError(
                code: "access.authorization_missing",
                titleKey: "error.access.title",
                messageKey: "error.access.authorization_missing",
                isRetryable: false
            )
        }
    }

    static func mapPolicy(_ error: PolicyApplyError) -> AppMappedError {
        switch error {
        case .authorizationMissing:
            return AppMappedError(
                code: "policy.authorization_missing",
                titleKey: "error.access.title",
                messageKey: "error.access.authorization_missing",
                isRetryable: false
            )
        case .inconsistentGroup:
            return AppMappedError(
                code: "policy.inconsistent_group",
                titleKey: "error.policy.title",
                messageKey: "error.policy.inconsistent_group",
                isRetryable: true
            )
        case .applyFailed:
            return AppMappedError(
                code: "policy.apply_failed",
                titleKey: "error.policy.title",
                messageKey: "error.policy.apply_failed",
                isRetryable: true
            )
        }
    }
}
