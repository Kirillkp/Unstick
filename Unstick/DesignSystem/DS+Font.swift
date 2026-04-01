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
}

extension DS.Font {
    static let largeTitle = bold(36)
    static let title1 = semiBold(25)
    static let title2 = semiBold(19)
    static let title3 = semiBold(17)
    static let headline = semiBold(14)
    static let body = regular(16)
    static let caption1 = regular(14)
    static let caption2 = regular(12)
}
