//
//  BlurConfiguration.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import Foundation
import UIKit

struct BlurConfiguration {
    
    var cornerRadius: CGFloat = 48
    
    var blurStyle: UIBlurEffect.Style = .systemUltraThinMaterial
    var blurAlpha: CGFloat = 0.1
    
    var tintColor: UIColor = UIColor(red: 51/255, green: 45/255, blue: 79/255, alpha: 0.1)
    
    var borderColor: UIColor = UIColor.white.withAlphaComponent(0.2)
    var borderWidth: CGFloat = 1
    
    var insets: UIEdgeInsets = .zero
}
