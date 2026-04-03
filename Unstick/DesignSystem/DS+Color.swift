//
//  DS+Color.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import UIKit

extension DS {
    
    enum Colors {
        static let primary = UIColor.hex("#9D52FF")
        static let secondary = UIColor.hex("#1F1D47")
        static let tertiary = UIColor.hex("#C4FF62")
        static let neutral = UIColor.hex("#0F0C29")

        /// button
        static let buttonPrimaryGradientStart = UIColor.hex("#C49AFF")
        static let buttonPrimaryGradientEnd = UIColor.hex("#9448F6")
        static let buttonPrimaryTitle = UIColor.hex("#420082")

        /// indicator
        static let indicatorRingBackground = UIColor.hex("#24204A").withAlphaComponent(0.6)
        static let indicatorRingGlow = UIColor.hex("#C49AFF").withAlphaComponent(0.3)
        static let indicatorFillBorder = UIColor.hex("#B06CFF")
        static let indicatorStatusPositive = UIColor.hex("#B2EC51")
        
        /// text
        static let textPrimary = UIColor.hex("#FFFFFF")
        static let textSecondary = UIColor.hex("#E7E2FF")
        static let textTertiary = UIColor.hex("#ACA7CC")
    }
}
