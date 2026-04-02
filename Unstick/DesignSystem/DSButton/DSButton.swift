//
//  DSButton.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 02.04.2026.
//

import UIKit

final class DSButton: UIButton {

    private let gradientLayer = CAGradientLayer()
    private var style: DS.ButtonStyle = .primary
    private var size: DS.ButtonSize = .m
    private let pressedScale: CGFloat = 0.97

    override var isHighlighted: Bool {
        didSet {
            animateHighlightState()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        setStyle(.primary, size: .m)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        setStyle(.primary, size: .m)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    override var intrinsicContentSize: CGSize {
        let baseSize = super.intrinsicContentSize
        return CGSize(
            width: baseSize.width,
            height: size.height
        )
    }

    func setStyle(
        _ style: DS.ButtonStyle,
        size: DS.ButtonSize = .m
    ) {
        self.style = style
        self.size = size

        let configuration = style.configuration
        let cornerRadius = configuration.cornerRadius ?? size.cornerRadius
        gradientLayer.colors = configuration.backgroundColors.map(\.cgColor)
        layer.cornerRadius = cornerRadius
        gradientLayer.cornerRadius = cornerRadius

        setTitleColor(configuration.titleColor, for: .normal)
        titleLabel?.font = configuration.titleFont
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    private func setup() {
        clipsToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 1.2)
        adjustsImageWhenHighlighted = false
    }

    private func animateHighlightState() {
        let targetTransform: CGAffineTransform = isHighlighted
            ? CGAffineTransform(scaleX: pressedScale, y: pressedScale)
            : .identity
        let targetAlpha: CGFloat = isHighlighted ? 0.82 : 1.0

        if isHighlighted {
            UIView.animate(
                withDuration: 0.12,
                delay: 0,
                options: [.beginFromCurrentState, .curveEaseOut, .allowUserInteraction]
            ) {
                self.transform = targetTransform
                self.alpha = targetAlpha
            }
        } else {
            UIView.animate(
                withDuration: 0.32,
                delay: 0,
                usingSpringWithDamping: 0.58,
                initialSpringVelocity: 0.4,
                options: [.beginFromCurrentState, .curveEaseInOut, .allowUserInteraction]
            ) {
                self.transform = targetTransform
                self.alpha = targetAlpha
            }
        }
    }
}
