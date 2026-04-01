//
//  UIColor+Hex.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init?(hex: String) {
        let hex = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        var int: UInt64 = 0
        guard Scanner(string: hex).scanHexInt64(&int) else {
            return nil
        }
        
        let r, g, b, a: UInt64
        
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b, a) = (
                ((int >> 8) & 0xF) * 17,
                ((int >> 4) & 0xF) * 17,
                (int & 0xF) * 17,
                255
            )
            
        case 4: // RGBA (16-bit)
            (r, g, b, a) = (
                ((int >> 12) & 0xF) * 17,
                ((int >> 8) & 0xF) * 17,
                ((int >> 4) & 0xF) * 17,
                (int & 0xF) * 17
            )
            
        case 6: // RRGGBB (24-bit)
            (r, g, b, a) = (
                (int >> 16) & 0xFF,
                (int >> 8) & 0xFF,
                int & 0xFF,
                255
            )
            
        case 8: // RRGGBBAA (32-bit)
            (r, g, b, a) = (
                (int >> 24) & 0xFF,
                (int >> 16) & 0xFF,
                (int >> 8) & 0xFF,
                int & 0xFF
            )
            
        default:
            return nil
        }
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: CGFloat(a) / 255
        )
    }
}

extension UIColor {
    
    static func hex(_ hex: String) -> UIColor {
        return UIColor(hex: hex) ?? .clear
    }
}
