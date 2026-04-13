//
//  MainPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import Foundation

// MARK: - CONFIG

let scriptURL = URL(fileURLWithPath: #filePath)
let projectRoot = scriptURL
    .deletingLastPathComponent()
    .deletingLastPathComponent()
    .path

let inputStringsPath = "\(projectRoot)/Unstick/Resources/Localizable.xcstrings"
let inputAssetsPath  = "\(projectRoot)/Unstick/Resources/Assets.xcassets"
let outputDir        = "\(projectRoot)/Unstick/Generated"
let outputL10n       = "\(outputDir)/L10n.swift"
let outputAssets     = "\(outputDir)/Assets.swift"

// MARK: - MODELS

struct XCStrings: Codable {
    let strings: [String: Entry]
}

struct Entry: Codable {
    let localizations: [String: Localization]?
}

struct Localization: Codable {
    let stringUnit: StringUnit?
}

struct StringUnit: Codable {
    let value: String
}

struct L10nEntry {
    let key: String
    let value: String
    let name: String
    let enValue: String?
    let ruValue: String?
}

final class L10nNode {
    var children: [String: L10nNode] = [:]
    var entries: [L10nEntry] = []
}

// MARK: - HELPERS

func argumentsCount(in string: String) -> Int {
    var count = 0
    var index = string.startIndex

    while index < string.endIndex {
        guard string[index] == "%" else {
            index = string.index(after: index)
            continue
        }

        let percentIndex = index
        index = string.index(after: index)
        guard index < string.endIndex else { break }

        if string[index] == "%" {
            index = string.index(after: index)
            continue
        }

        while index < string.endIndex, string[index].isNumber {
            index = string.index(after: index)
        }
        if index < string.endIndex, string[index] == "$" {
            index = string.index(after: index)
        } else {
            index = string.index(after: percentIndex)
        }

        while index < string.endIndex, "-+ #0'".contains(string[index]) {
            index = string.index(after: index)
        }

        if index < string.endIndex {
            if string[index] == "*" {
                count += 1
                index = string.index(after: index)
            } else {
                while index < string.endIndex, string[index].isNumber {
                    index = string.index(after: index)
                }
            }
        }

        if index < string.endIndex, string[index] == "." {
            index = string.index(after: index)
            if index < string.endIndex, string[index] == "*" {
                count += 1
                index = string.index(after: index)
            } else {
                while index < string.endIndex, string[index].isNumber {
                    index = string.index(after: index)
                }
            }
        }

        if index < string.endIndex {
            if string[index] == "h" {
                index = string.index(after: index)
                if index < string.endIndex, string[index] == "h" {
                    index = string.index(after: index)
                }
            } else if string[index] == "l" {
                index = string.index(after: index)
                if index < string.endIndex, string[index] == "l" {
                    index = string.index(after: index)
                }
            } else if "qLjzt".contains(string[index]) {
                index = string.index(after: index)
            }
        }

        if index < string.endIndex {
            count += 1
            index = string.index(after: index)
        }
    }

    return count
}

func camelCase(_ string: String) -> String {
    guard string.contains("_") else {
        return string.prefix(1).lowercased() + string.dropFirst()
    }

    let parts = string.split(separator: "_")
    return parts.enumerated().map {
        $0 == 0 ? $1.lowercased() : $1.capitalized
    }.joined()
}

func pascalCase(_ string: String) -> String {
    string.prefix(1).uppercased() + string.dropFirst()
}

func indent(_ level: Int) -> String {
    String(repeating: "    ", count: level)
}

func escapedDocCommentValue(_ value: String?) -> String {
    guard let value else { return "-" }
    return value.replacingOccurrences(of: "\n", with: "\\n")
}

func render(node: L10nNode, level: Int) -> String {
    var result = ""

    for childKey in node.children.keys.sorted() {
        guard let childNode = node.children[childKey] else { continue }
        result += "\n\(indent(level))enum \(pascalCase(childKey)) {"
        result += render(node: childNode, level: level + 1)
        result += "\n\(indent(level))}\n"
    }

    for entry in node.entries.sorted(by: { $0.key < $1.key }) {
        let argsCount = argumentsCount(in: entry.value)
        let enValue = escapedDocCommentValue(entry.enValue)
        let ruValue = escapedDocCommentValue(entry.ruValue)

        if argsCount == 0 {
            result += """

\(indent(level))    /// EN: \(enValue)
\(indent(level))    /// RU: \(ruValue)
\(indent(level))    static let \(entry.name) = String(localized: "\(entry.key)")

"""
        } else {
            let params = (0..<argsCount).map { "arg\($0): CVarArg" }.joined(separator: ", ")
            let args = (0..<argsCount).map { "arg\($0)" }.joined(separator: ", ")
            result += """

\(indent(level))    /// EN: \(enValue)
\(indent(level))    /// RU: \(ruValue)
\(indent(level))    static func \(entry.name)(\(params)) -> String {
\(indent(level))        String(format: String(localized: "\(entry.key)"), \(args))
\(indent(level))    }

"""
        }
    }

    return result
}

// MARK: - L10N GENERATION

func generateL10n() throws {
    let data = try Data(contentsOf: URL(fileURLWithPath: inputStringsPath))
    let decoded = try JSONDecoder().decode(XCStrings.self, from: data)

    let root = L10nNode()

    for (key, entry) in decoded.strings {
        let enValue = entry.localizations?["en"]?.stringUnit?.value
        let ruValue = entry.localizations?["ru"]?.stringUnit?.value
        let fallbackValue = entry.localizations?.values.compactMap { $0.stringUnit?.value }.first
        guard let value = enValue ?? ruValue ?? fallbackValue else { continue }
        let parts = key.split(separator: ".")
        guard parts.count >= 2 else { continue }

        var currentNode = root
        for namespace in parts.dropLast() {
            let key = pascalCase(String(namespace))
            if currentNode.children[key] == nil {
                currentNode.children[key] = L10nNode()
            }
            currentNode = currentNode.children[key]!
        }

        let leafName = camelCase(String(parts.last!))
        currentNode.entries.append(
            L10nEntry(
                key: key,
                value: value,
                name: leafName,
                enValue: enValue,
                ruValue: ruValue
            )
        )
    }

    var result = """
    // AUTO-GENERATED FILE. DO NOT EDIT.

    import Foundation

    enum L10n {

    """

    result += render(node: root, level: 1)

    result += "}"

    try FileManager.default.createDirectory(
        atPath: outputDir,
        withIntermediateDirectories: true
    )

    try result.write(toFile: outputL10n, atomically: true, encoding: .utf8)

    print("L10n generated")
}

// MARK: - ASSETS GENERATION

func generateAssets() throws {
    var result = """
    // AUTO-GENERATED FILE. DO NOT EDIT.

    import UIKit

    enum Assets {

    """

    let assetEntries = try assetEntriesRecursively(in: inputAssetsPath)
    var usedPropertyNames = Set<String>()

    for entry in assetEntries {
        let basePropertyName = camelCase(entry.assetName)
        let propertyName: String

        if usedPropertyNames.insert(basePropertyName).inserted {
            propertyName = basePropertyName
        } else {
            let fallbackPropertyName = camelCase(entry.relativePathKey)
            usedPropertyNames.insert(fallbackPropertyName)
            propertyName = fallbackPropertyName
        }

        switch entry.kind {
        case .image:
            result += "\n    static let \(propertyName) = UIImage(named: \"\(entry.assetName)\")!"
        case .color:
            result += "\n    static let \(propertyName) = UIColor(named: \"\(entry.assetName)\")!"
        case .appIcon:
            continue
        }
    }

    result += "\n}"

    try result.write(toFile: outputAssets, atomically: true, encoding: .utf8)

    print("Assets generated")
}

func cleanAssetName(_ name: String) -> String {
    return name
        .replacingOccurrences(of: ".imageset", with: "")
        .replacingOccurrences(of: ".appiconset", with: "")
        .replacingOccurrences(of: ".colorset", with: "")
}

enum AssetKind {
    case image
    case color
    case appIcon
}

struct AssetEntry {
    let kind: AssetKind
    let assetName: String
    let relativePathKey: String
}

func assetEntriesRecursively(in assetsPath: String) throws -> [AssetEntry] {
    let fm = FileManager.default
    guard let enumerator = fm.enumerator(atPath: assetsPath) else {
        return []
    }

    var entries: [AssetEntry] = []

    for case let relativePath as String in enumerator {
        let fullPath = "\(assetsPath)/\(relativePath)"

        var isDirectory: ObjCBool = false
        guard fm.fileExists(atPath: fullPath, isDirectory: &isDirectory), isDirectory.boolValue else {
            continue
        }

        if relativePath.hasSuffix(".imageset") {
            let assetName = cleanAssetName((relativePath as NSString).lastPathComponent)
            let relativeKey = assetRelativeKey(relativePath)
            entries.append(
                AssetEntry(
                    kind: .image,
                    assetName: assetName,
                    relativePathKey: relativeKey
                )
            )
            enumerator.skipDescendants()
        } else if relativePath.hasSuffix(".colorset") {
            let assetName = cleanAssetName((relativePath as NSString).lastPathComponent)
            let relativeKey = assetRelativeKey(relativePath)
            entries.append(
                AssetEntry(
                    kind: .color,
                    assetName: assetName,
                    relativePathKey: relativeKey
                )
            )
            enumerator.skipDescendants()
        } else if relativePath.hasSuffix(".appiconset") {
            enumerator.skipDescendants()
        }
    }

    return entries.sorted { $0.relativePathKey < $1.relativePathKey }
}

func assetRelativeKey(_ relativePath: String) -> String {
    relativePath
        .replacingOccurrences(of: ".imageset", with: "")
        .replacingOccurrences(of: ".appiconset", with: "")
        .replacingOccurrences(of: ".colorset", with: "")
        .replacingOccurrences(of: "/", with: "_")
}

// MARK: - RUN

do {
    try generateL10n()
    try generateAssets()
} catch {
    print("Generation failed:", error)
}
