//
//  UIView+BlurBackgroundView.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import UIKit
import SnapKit

extension UIView {
    
    @discardableResult
    func addBlurBackground(
        configuration: BlurConfiguration = .init()
    ) -> BlurBackgroundView {
        let blurView = BlurBackgroundView(configuration: configuration)
        insertSubview(blurView, at: 0)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(configuration.insets)
        }
        
        return blurView
    }
    
    @discardableResult
    func addBlurBackground(
        frame: CGRect,
        configuration: BlurConfiguration = .init()
    ) -> BlurBackgroundView {
        let blurView = BlurBackgroundView(configuration: configuration)
        blurView.frame = frame
        insertSubview(blurView, at: 0)
        return blurView
    }
}
