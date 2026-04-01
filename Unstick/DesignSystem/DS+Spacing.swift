//
//  DS+Spacing.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import UIKit

extension DS {
    
    enum Spacing {
        public static let x1: CGFloat = 2
        public static let x2: CGFloat = 2
        public static let x4: CGFloat = 4
        public static let x6: CGFloat = 6
        public static let x8: CGFloat = 8
        public static let x10: CGFloat = 10
        public static let x12: CGFloat = 12
        public static let x14: CGFloat = 14
        public static let x16: CGFloat = 16
        public static let x20: CGFloat = 20
        public static let x24: CGFloat = 24
        public static let x32: CGFloat = 32
        public static let x48: CGFloat = 48
        public static let x64: CGFloat = 64
    }
}

extension DS.Spacing {
    
    static var s: UIEdgeInsets { .init(all: x8) }
    static var m: UIEdgeInsets { .init(all: x16) }
    static var l: UIEdgeInsets { .init(all: x24) }
}
