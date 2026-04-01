//
//  BlurBackgroundView.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import UIKit
import SnapKit

final class BlurBackgroundView: UIView {
    
    // MARK: - Public
    
    var configuration: BlurConfiguration {
        didSet { applyConfiguration() }
    }
    
    // MARK: - UI
    
    private let blurView = UIVisualEffectView()
    private let tintView = UIView()
    
    // MARK: - Init
    
    init(configuration: BlurConfiguration = .init()) {
        self.configuration = configuration
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.configuration = .init()
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        clipsToBounds = true
        
        addSubview(blurView)
        addSubview(tintView)
        
        blurView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tintView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        applyConfiguration()
    }
    
    private func applyConfiguration() {
        blurView.effect = UIBlurEffect(style: configuration.blurStyle)
        blurView.alpha = configuration.blurAlpha
        
        tintView.backgroundColor = configuration.tintColor
        
        layer.cornerRadius = configuration.cornerRadius
        layer.borderColor = configuration.borderColor.cgColor
        layer.borderWidth = configuration.borderWidth
    }
}
