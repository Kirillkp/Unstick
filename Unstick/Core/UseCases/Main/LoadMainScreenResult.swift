//
//  LoadMainScreenResult.swift
//  Unstick
//
//  Created by Codex on 12.04.2026.
//

import Foundation

/// Результат загрузки главного экрана.
enum LoadMainScreenResult {
    /// Нет доступа к системным ограничениям.
    case noAccess
    /// Доступ есть, но у пользователя еще нет групп.
    case empty
    /// Доступ есть и группы присутствуют.
    case filled(groups: [RestrictionGroup])
}
