//
//  DSButton.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 02.04.2026.
//

import UIKit

final class DSButton: UIButton {

    private let gradientLayer = CAGradientLayer()
    private let borderLayer = CAShapeLayer()
    private var style: DS.ButtonStyle = .primary
    private var size: DS.ButtonSize = .m
    private var imageSpacing: CGFloat = 0
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
        borderLayer.frame = bounds
        borderLayer.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: layer.cornerRadius
        ).cgPath
        updateImageSpacing()
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
        imageSpacing = configuration.imageSpacing
        layer.cornerRadius = cornerRadius
        gradientLayer.cornerRadius = cornerRadius
        borderLayer.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath

        applyBackgroundStyle(configuration.backgroundStyle)
        applyBorderStyle(configuration.borderStyle)

        setTitleColor(configuration.titleColor, for: .normal)
        tintColor = configuration.titleColor
        titleLabel?.font = configuration.titleFont
        semanticContentAttribute = configuration.semanticContentAttribute
        imageView?.contentMode = .scaleAspectFit

        if let symbolConfiguration = configuration.imageSymbolConfiguration {
            setPreferredSymbolConfiguration(symbolConfiguration, forImageIn: .normal)
        }

        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }

    private func setup() {
        clipsToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
        layer.addSublayer(borderLayer)
        gradientLayer.startPoint = CGPoint(x: 0.2, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 1.2)
        adjustsImageWhenHighlighted = false
    }

    func applyBackgroundStyle(_ style: DS.ButtonBackgroundStyle) {
        switch style {
        case .gradient(let colors):
            gradientLayer.isHidden = false
            gradientLayer.colors = colors.map(\.cgColor)
        case .clear:
            gradientLayer.isHidden = true
            gradientLayer.colors = nil
        }
    }

    func applyBorderStyle(_ style: DS.ButtonBorderStyle) {
        switch style {
        case .none:
            borderLayer.isHidden = true
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = UIColor.clear.cgColor
            borderLayer.lineWidth = 0
            borderLayer.lineDashPattern = nil
        case .dashed(let color, let lineWidth, let dashPattern):
            borderLayer.isHidden = false
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = color.cgColor
            borderLayer.lineWidth = lineWidth
            borderLayer.lineDashPattern = dashPattern
        }
    }

    func updateImageSpacing() {
        guard imageSpacing > 0 else {
            titleEdgeInsets = .zero
            imageEdgeInsets = .zero
            return
        }

        titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageSpacing,
            bottom: 0,
            right: -imageSpacing
        )
        imageEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSpacing / 2,
            bottom: 0,
            right: imageSpacing / 2
        )
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
