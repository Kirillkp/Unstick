//
//  DS+Font.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import UIKit

extension DS {
    enum Font {
        
        static func regular(_ size: CGFloat) -> UIFont {
            UIFont(name: "Manrope-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
        }
        
        static func extraLight(_ size: CGFloat) -> UIFont {
            UIFont(name: "Manrope-ExtraLight", size: size) ?? UIFont.systemFont(ofSize: size, weight: .ultraLight)
        }
        
        static func light(_ size: CGFloat) -> UIFont {
            UIFont(name: "Manrope-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: .light)
        }
        
        static func medium(_ size: CGFloat) -> UIFont {
            UIFont(name: "Manrope-Medium", size: size) ?? UIFont.systemFont(ofSize: size, weight: .medium)
        }
        
        static func semiBold(_ size: CGFloat) -> UIFont {
            UIFont(name: "Manrope-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        
        static func bold(_ size: CGFloat) -> UIFont {
            UIFont(name: "Manrope-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
        }
        
        static func extraBold(_ size: CGFloat) -> UIFont {
            UIFont(name: "Manrope-ExtraBold", size: size) ?? UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }
    
    enum FontStyle {
        case largeTitle
        case title1
        case title2
        case title3
        case headline
        case body
        case caption1
        case caption2
        
        var font: UIFont {
            switch self {
            case .largeTitle: return DS.Font.bold(36)
            case .title1: return DS.Font.semiBold(25)
            case .title2: return DS.Font.semiBold(19)
            case .title3: return DS.Font.semiBold(17)
            case .headline: return DS.Font.semiBold(14)
            case .body: return DS.Font.regular(16)
            case .caption1: return DS.Font.regular(14)
            case .caption2: return DS.Font.regular(12)
            }
        }
        
        var lineHeight: CGFloat {
            switch self {
            case .largeTitle: return 39
            case .title1: return 31
            case .title2: return 26
            case .title3: return 22
            case .headline: return 19
            case .body: return 26
            case .caption1: return 13
            case .caption2: return 13
            }
        }
    }
}

extension UILabel {
    func applyFontStyle(_ style: DS.FontStyle) {
        self.font = style.font
        self.numberOfLines = 0
        
        guard let text = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = style.lineHeight
        paragraphStyle.maximumLineHeight = style.lineHeight
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        self.attributedText = NSAttributedString(
            string: text,
            attributes: [
                .font: style.font,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: self.textColor ?? UIColor.label
            ]
        )
    }
}
