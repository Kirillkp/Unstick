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

        /// semantic
        static let surfacePrimary = UIColor.hex("#24204A")
        static let surfaceElevated = UIColor.hex("#2A2653")
        static let borderPrimary = UIColor.hex("#474464")
        static let backgroundDanger = UIColor.hex("#A70138")
        static let borderDanger = UIColor.hex("#FF6E84")

        /// button
        static let buttonPrimaryGradientStart = UIColor.hex("#C49AFF")
        static let buttonPrimaryGradientEnd = UIColor.hex("#9448F6")
        static let buttonPrimaryTitle = UIColor.hex("#420082")
        static let buttonSecondaryTitle = UIColor.hex("#ACA7CC")

        /// indicator
        static let indicatorFillBorder = UIColor.hex("#B06CFF")
        static let indicatorStatusPositive = UIColor.hex("#B2EC51")

        /// usage card
        static let usageCardProgressTrack = surfacePrimary
        static let usageCardIconBackground = surfaceElevated
        static let usageCardProgressPrimaryStart = UIColor.hex("#C49AFF")
        static let usageCardProgressPrimaryEnd = UIColor.hex("#9448F6")
        static let usageCardProgressWarningStart = UIColor.hex("#FBBF24")
        static let usageCardProgressWarningEnd = UIColor.hex("#F97316")
        static let usageCardProgressDangerStart = UIColor.hex("#FF6E84")
        static let usageCardProgressDangerEnd = UIColor.hex("#D73357")
        
        /// text
        static let textPrimary = UIColor.hex("#FFFFFF")
        static let textSecondary = UIColor.hex("#E7E2FF")
        static let textTertiary = UIColor.hex("#ACA7CC")
        static let textDanger = UIColor.hex("#FF6E84")
    }
}
