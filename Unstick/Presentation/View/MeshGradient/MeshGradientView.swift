//
//  MeshGradientView.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 31.03.2026.
//

import UIKit
import SwiftUI
import SnapKit

final class MeshGradientView: UIView {
    
    private var hostingController: UIHostingController<AnimatedMeshGradientView>?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let swiftUIView = AnimatedMeshGradientView()
        let hosting = UIHostingController(rootView: swiftUIView)
        
        hosting.view.backgroundColor = .clear
        
        addSubview(hosting.view)
        hosting.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.hostingController = hosting
    }
}
