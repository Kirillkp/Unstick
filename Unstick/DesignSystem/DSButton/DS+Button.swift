//
//  DS+Button.swift
//  Unstick
//
//  Created by Codex on 02.04.2026.
//

import UIKit

extension DS {
    enum ButtonBackgroundStyle {
        case gradient([UIColor])
        case clear
    }

    enum ButtonBorderStyle {
        case none
        case dashed(
            color: UIColor,
            lineWidth: CGFloat,
            dashPattern: [NSNumber]
        )
    }

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
        let backgroundStyle: ButtonBackgroundStyle
        let borderStyle: ButtonBorderStyle
        let titleColor: UIColor
        let titleFont: UIFont
        let imageSpacing: CGFloat
        let imageSymbolConfiguration: UIImage.SymbolConfiguration?
        let semanticContentAttribute: UISemanticContentAttribute
        let cornerRadius: CGFloat?

        init(
            backgroundStyle: ButtonBackgroundStyle,
            borderStyle: ButtonBorderStyle = .none,
            titleColor: UIColor,
            titleFont: UIFont,
            imageSpacing: CGFloat = 0,
            imageSymbolConfiguration: UIImage.SymbolConfiguration? = nil,
            semanticContentAttribute: UISemanticContentAttribute = .unspecified,
            cornerRadius: CGFloat? = nil
        ) {
            self.backgroundStyle = backgroundStyle
            self.borderStyle = borderStyle
            self.titleColor = titleColor
            self.titleFont = titleFont
            self.imageSpacing = imageSpacing
            self.imageSymbolConfiguration = imageSymbolConfiguration
            self.semanticContentAttribute = semanticContentAttribute
            self.cornerRadius = cornerRadius
        }
    }

    enum ButtonStyle {
        case primary
        case secondaryDashed
        case custom(ButtonConfiguration)

        var configuration: ButtonConfiguration {
            switch self {
            case .primary:
                return ButtonConfiguration(
                    backgroundStyle: .gradient([
                        DS.Colors.buttonPrimaryGradientStart,
                        DS.Colors.buttonPrimaryGradientEnd
                    ]),
                    titleColor: DS.Colors.buttonPrimaryTitle,
                    titleFont: DS.Font.bold(18),
                    cornerRadius: nil
                )
            case .secondaryDashed:
                return ButtonConfiguration(
                    backgroundStyle: .clear,
                    borderStyle: .dashed(
                        color: DS.Colors.borderPrimary,
                        lineWidth: 2,
                        dashPattern: [6, 6]
                    ),
                    titleColor: DS.Colors.buttonSecondaryTitle,
                    titleFont: DS.Font.bold(16),
                    imageSpacing: DS.Spacing.x4,
                    imageSymbolConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium),
                    semanticContentAttribute: .forceLeftToRight,
                    cornerRadius: nil
                )
            case .custom(let configuration):
                return configuration
            }
        }
    }
}
