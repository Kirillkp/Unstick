//
//  SettingsRowItemModel.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit

nonisolated struct SettingsRowItemModel: Hashable, Sendable {
    enum IconStyle: Hashable, Sendable {
        case indigo
        case violet
        case red
        case cyan
        case orange
        case magenta
        case green
        case yellow
        case mint
        case teal
        case blue
        case pink
        case gray

        var backgroundColor: UIColor {
            switch self {
            case .indigo:
                UIColor.hex("#2B4D9C")
            case .violet:
                UIColor.hex("#7943C9")
            case .red:
                UIColor.hex("#B2395A")
            case .cyan:
                UIColor.hex("#2C7FA0")
            case .orange:
                UIColor.hex("#A0622D")
            case .magenta:
                UIColor.hex("#9A3F8A")
            case .green:
                UIColor.hex("#2F8B57")
            case .yellow:
                UIColor.hex("#9E8730")
            case .mint:
                UIColor.hex("#2C8E83")
            case .teal:
                UIColor.hex("#3A8A92")
            case .blue:
                UIColor.hex("#3767B5")
            case .pink:
                UIColor.hex("#A54273")
            case .gray:
                UIColor.hex("#5A5D74")
            }
        }

        var tintColor: UIColor {
            switch self {
            case .indigo:
                UIColor.hex("#BFD1FF")
            case .violet:
                UIColor.hex("#E1C7FF")
            case .red:
                UIColor.hex("#FFD2DC")
            case .cyan:
                UIColor.hex("#C4F0FF")
            case .orange:
                UIColor.hex("#FFDDBA")
            case .magenta:
                UIColor.hex("#FFCFF4")
            case .green:
                UIColor.hex("#CCFFD9")
            case .yellow:
                UIColor.hex("#FFF0B5")
            case .mint:
                UIColor.hex("#C8FFF4")
            case .teal:
                UIColor.hex("#CBF7FF")
            case .blue:
                UIColor.hex("#D3E2FF")
            case .pink:
                UIColor.hex("#FFD6EB")
            case .gray:
                UIColor.hex("#E1E3F0")
            }
        }
    }

    enum Accessory: Hashable, Sendable {
        case chevron
        case valueWithChevron(String)
        case value(String)
        case toggle(isOn: Bool)
    }

    let id: UUID
    let title: String
    let iconSystemName: String
    let iconStyle: IconStyle
    let accessory: Accessory

    init(
        id: UUID = UUID(),
        title: String,
        iconSystemName: String,
        iconStyle: IconStyle,
        accessory: Accessory
    ) {
        self.id = id
        self.title = title
        self.iconSystemName = iconSystemName
        self.iconStyle = iconStyle
        self.accessory = accessory
    }
}
