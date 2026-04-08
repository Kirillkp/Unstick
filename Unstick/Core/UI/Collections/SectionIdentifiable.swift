//
//  SectionIdentifiable.swift
//  Unstick
//
//  Created by Codex on 07.04.2026.
//

import Foundation

protocol SectionIdentifiable: Hashable, Sendable {
    var sectionIdentifier: String { get }
}
