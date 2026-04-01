//
//  MeshGradients+Noise.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import Foundation

// MARK: - Noise

func noise(_ t: Double, offset: Double) -> Double {
    let x = t + offset
    
    let i = floor(x)
    let f = x - i
    
    let u = f * f * (3.0 - 2.0 * f)
    
    let a = random(i)
    let b = random(i + 1.0)
    
    return mix(a, b, u)
}

func random(_ x: Double) -> Double {
    return fract(sin(x * 12.9898) * 43758.5453)
}

func fract(_ x: Double) -> Double {
    x - floor(x)
}

func mix(_ a: Double, _ b: Double, _ t: Double) -> Double {
    a + (b - a) * t
}

func clamp(_ x: Double, minValue: Double = 0.0, maxValue: Double = 1.0) -> Double {
    return min(max(x, minValue), maxValue)
}
