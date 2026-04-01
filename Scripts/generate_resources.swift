//
//  MainPresenter.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import Foundation

// MARK: - CONFIG

let projectRoot = FileManager.default.currentDirectoryPath

let inputStringsPath = "\(projectRoot)/Unstick/Unstick/Resources/Localizable.xcstrings"
let inputAssetsPath  = "\(projectRoot)/Unstick/Unstick/Resources/Assets.xcassets"
let outputDir        = "\(projectRoot)/Unstick/Unstick/Generated"
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

// MARK: - HELPERS

func argumentsCount(in string: String) -> Int {
    return string.components(separatedBy: "%@").count - 1
}

func camelCase(_ string: String) -> String {
    let parts = string.split(separator: "_")
    return parts.enumerated().map {
        $0 == 0 ? $1.lowercased() : $1.capitalized
    }.joined()
}

func pascalCase(_ string: String) -> String {
    string.prefix(1).uppercased() + string.dropFirst()
}

// MARK: - L10N GENERATION

func generateL10n() throws {
    let data = try Data(contentsOf: URL(fileURLWithPath: inputStringsPath))
    let decoded = try JSONDecoder().decode(XCStrings.self, from: data)

    // Сгруппируем ключи по namespace
    var groups: [String: [(key: String, value: String)]] = [:]

    for (key, entry) in decoded.strings {
        guard let value = entry.localizations?.first?.value.stringUnit?.value else { continue }
        let parts = key.split(separator: ".")
        guard parts.count == 2 else { continue }
        let group = String(parts[0]).capitalized
        let name = String(parts[1])
        groups[group, default: []].append((key: key, value: value))
    }

    // Генерируем enum
    var result = """
    // AUTO-GENERATED FILE. DO NOT EDIT.

    import Foundation

    enum L10n {

    """

    for (group, entries) in groups.sorted(by: { $0.key < $1.key }) {
        result += "\n    enum \(group) {"

        for entry in entries.sorted(by: { $0.key < $1.key }) {
            let parts = entry.key.split(separator: ".")
            let name = camelCase(String(parts[1]))
            let argsCount = argumentsCount(in: entry.value)

            if argsCount == 0 {
                result += """
                
                    static let \(name) = String(localized: "\(entry.key)")
                
                """
            } else {
                let params = (0..<argsCount).map { "arg\($0): CVarArg" }.joined(separator: ", ")
                let args = (0..<argsCount).map { "arg\($0)" }.joined(separator: ", ")
                result += """
                
                    static func \(name)(\(params)) -> String {
                        String(format: String(localized: "\(entry.key)"), \(args))
                    }
                
                """
            }
        }

        result += "\n    }\n"
    }

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
    let fm = FileManager.default

    var result = """
    // AUTO-GENERATED FILE. DO NOT EDIT.

    import UIKit

    enum Assets {

    """

    let items = try fm.contentsOfDirectory(atPath: inputAssetsPath)

    for item in items {
        let itemPath = "\(inputAssetsPath)/\(item)"

        var isDir: ObjCBool = false
        guard fm.fileExists(atPath: itemPath, isDirectory: &isDir), isDir.boolValue else { continue }

        if item.hasSuffix(".imageset") {
            let name = cleanAssetName(item)
            let propertyName = camelCase(name)
            result += "\n    static let \(propertyName) = UIImage(named: \"\(name)\")!"
        } else if item.hasSuffix(".colorset") {
            let name = cleanAssetName(item)
            let propertyName = camelCase(name)
            result += "\n    static let \(propertyName) = UIColor(named: \"\(name)\")!"
        } else if item.hasSuffix(".appiconset") {
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

// MARK: - RUN

do {
    try generateL10n()
    try generateAssets()
} catch {
    print("Generation failed:", error)
}
