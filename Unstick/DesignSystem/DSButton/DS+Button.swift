//
//  DS+Button.swift
//  Unstick
//
//  Created by Codex on 02.04.2026.
//

import UIKit

extension DS {

    enum ButtonSize {
        case m
        case xl

        var height: CGFloat {
            switch self {
            case .m:
                return 50
            case .xl:
                return 64
            }
        }

        var cornerRadius: CGFloat {
            switch self {
            case .m:
                return DS.CornerRadius.buttonMedium
            case .xl:
                return DS.CornerRadius.buttonExtraLarge
            }
        }
    }

    struct ButtonConfiguration {
        let backgroundColors: [UIColor]
        let titleColor: UIColor
        let titleFont: UIFont
        let cornerRadius: CGFloat?

        init(
            backgroundColors: [UIColor],
            titleColor: UIColor,
            titleFont: UIFont,
            cornerRadius: CGFloat? = nil
        ) {
            self.backgroundColors = backgroundColors
            self.titleColor = titleColor
            self.titleFont = titleFont
            self.cornerRadius = cornerRadius
        }
    }

    enum ButtonStyle {
        case primary
        case custom(ButtonConfiguration)

        var configuration: ButtonConfiguration {
            switch self {
            case .primary:
                return ButtonConfiguration(
                    backgroundColors: [
                        DS.Colors.buttonPrimaryGradientStart,
                        DS.Colors.buttonPrimaryGradientEnd
                    ],
                    titleColor: DS.Colors.buttonPrimaryTitle,
                    titleFont: DS.Font.bold(18),
                    cornerRadius: nil
                )
            case .custom(let configuration):
                return configuration
            }
        }
    }
}
