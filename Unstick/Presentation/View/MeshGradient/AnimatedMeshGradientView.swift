//
//  AnimatedMeshGradientView.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import Foundation
import SwiftUI

struct AnimatedMeshGradientView: View {
    
    private let amplitude: Double
    private let speed: Double
    
    init(
        amplitude: Double = 0.25,
        speed: Double = 0.1
    ) {
        self.amplitude = amplitude
        self.speed = speed
    }
    
    var body: some View {
        TimelineView(.animation) { timeline in
            
            let time = timeline.date.timeIntervalSinceReferenceDate * speed
            
            // MARK: - Noise driven points
            
            let centerX = clamp(0.5 + amplitude * (noise(time, offset: 0.0) - 0.5))
            let centerY = clamp(0.5 + amplitude * (noise(time, offset: 10.0) - 0.5))
            let topMidX = clamp(0.5 + (amplitude * 0.6) * (noise(time, offset: 20.0) - 0.5))
            
            // MARK: - Points
            
            let points: [SIMD2<Float>] = [
                SIMD2(0.0, 0.0),
                SIMD2(Float(topMidX), 0.0),
                SIMD2(1.0, 0.0),
                
                SIMD2(0.0, 0.5),
                SIMD2(Float(centerX), Float(centerY)),
                SIMD2(1.0, 0.5),
                
                SIMD2(0.0, 1.0),
                SIMD2(0.5, 1.0),
                SIMD2(1.0, 1.0)
            ]
            
            // MARK: - Colors (под твой дизайн)
            
            let colors: [Color] = [
                Color(red: 0.08, green: 0.07, blue: 0.2),
                Color(red: 0.15, green: 0.1, blue: 0.35),
                Color(red: 0.05, green: 0.05, blue: 0.15),
                
                Color(red: 0.1, green: 0.08, blue: 0.25),
                Color(red: 0.2, green: 0.15, blue: 0.45),
                Color(red: 0.07, green: 0.07, blue: 0.2),
                
                Color.black,
                Color(red: 0.08, green: 0.07, blue: 0.2),
                Color(red: 0.12, green: 0.1, blue: 0.3)
            ]
            
            MeshGradient(
                width: 3,
                height: 3,
                points: points,
                colors: colors
            )
            .ignoresSafeArea()
        }
    }
}
