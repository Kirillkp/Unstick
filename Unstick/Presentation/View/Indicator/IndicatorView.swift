//
//  IndicatorView.swift
//  Unstick
//
//  Created by Codex on 03.04.2026.
//

import UIKit
import SnapKit

final class IndicatorView: UIView {

    struct FilledContent {
        let title: String
        let value: String
        let statusText: String

        init(
            title: String = L10n.Indicator.Fill.today,
            value: String,
            statusText: String
        ) {
            self.title = title
            self.value = value
            self.statusText = statusText
        }
    }

    struct EmptyContent {
        let title: String
        let subtitle: String

        init(
            title: String = L10n.Indicator.Empty.today,
            subtitle: String = L10n.Indicator.Empty.todayNotStarted
        ) {
            self.title = title
            self.subtitle = subtitle
        }
    }

    enum State {
        case empty(EmptyContent)
        case fill(FilledContent)
    }
    
    private enum Layout {
        static let ringSize: CGSize = CGSize(width: 224, height: 224)
    }

    private let ringContainerView = UIView()
    private let ringGradientLayer = CAGradientLayer()
    private let glowView = UIView()
    private let filledStackView = UIStackView()
    private let emptyStackView = UIStackView()
    private let filledTitleLabel = UILabel()
    private let filledValueLabel = UILabel()
    private let statusContainerView = UIStackView()
    private let statusIconView = UIImageView()
    private let statusLabel = UILabel()
    private let emptyTitleLabel = UILabel()
    private let emptySubtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
        setState(.empty(.init()))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
        setState(.empty(.init()))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        [ringContainerView, glowView].forEach {
            $0.layer.cornerRadius = $0.bounds.height / 2
        }
        ringGradientLayer.frame = ringContainerView.bounds
        ringGradientLayer.cornerRadius = ringContainerView.bounds.height / 2
        glowView.layer.shadowPath = UIBezierPath(
            ovalIn: glowView.bounds
        ).cgPath
    }

    func setState(_ state: State) {
        switch state {
        case .empty(let content):
            applyEmpty(content)
        case .fill(let content):
            applyFill(content)
        }
    }

    private func applyEmpty(_ content: EmptyContent) {
        filledStackView.isHidden = true
        emptyStackView.isHidden = false
        emptyTitleLabel.text = content.title
        emptySubtitleLabel.text = content.subtitle
    }

    private func applyFill(_ content: FilledContent) {
        filledStackView.isHidden = false
        emptyStackView.isHidden = true
        filledTitleLabel.text = content.title
        filledValueLabel.text = content.value
        statusLabel.text = content.statusText
    }
}

// MARK: Create UI

private extension IndicatorView {
    func createUI() {
        setupCardView()
        setupGlowView()
        setupRingContainerView()
        setupFilledStackView()
        setupFilledTitleLabel()
        setupFilledValueLabel()
        setupStatusContainerView()
        setupStatusIconView()
        setupStatusLabel()
        setupEmptyStackView()
        setupEmptyTitleLabel()
        setupEmptySubtitleLabel()
    }

    func setupCardView() {
        backgroundColor = .clear
    }

    func setupGlowView() {
        addSubview(glowView)
        glowView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.ringSize)
        }
        glowView.backgroundColor = .clear
        glowView.layer.shadowColor = DS.Colors.buttonPrimaryGradientStart.withAlphaComponent(0.3).cgColor
        glowView.layer.shadowOpacity = 1
        glowView.layer.shadowRadius = DS.CornerRadius.x40
        glowView.layer.shadowOffset = .zero
    }

    func setupRingContainerView() {
        addSubview(ringContainerView)
        ringContainerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.ringSize)
        }
        ringContainerView.layer.borderColor = DS.Colors.indicatorFillBorder.cgColor
        ringContainerView.backgroundColor = DS.Colors.surfacePrimary.withAlphaComponent(0.6)
        ringContainerView.layer.borderWidth = DS.Spacing.x8
        ringContainerView.clipsToBounds = true
    }

    func setupFilledStackView() {
        ringContainerView.addSubview(filledStackView)
        filledStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x32)
        }
        filledStackView.axis = .vertical
        filledStackView.alignment = .center
        filledStackView.spacing = DS.Spacing.x4
    }

    func setupFilledTitleLabel() {
        filledStackView.addArrangedSubview(filledTitleLabel)
        filledTitleLabel.textColor = DS.Colors.textTertiary
        filledTitleLabel.font = DS.Font.regular(12)
        filledTitleLabel.textAlignment = .center
    }

    func setupFilledValueLabel() {
        filledStackView.addArrangedSubview(filledValueLabel)
        filledValueLabel.textColor = DS.Colors.textPrimary
        filledValueLabel.font = DS.Font.extraBold(48)
        filledValueLabel.textAlignment = .center
    }

    func setupStatusContainerView() {
        filledStackView.addArrangedSubview(statusContainerView)
        statusContainerView.axis = .horizontal
        statusContainerView.alignment = .center
        statusContainerView.spacing = DS.Spacing.x4
    }

    func setupStatusIconView() {
        statusContainerView.addArrangedSubview(statusIconView)
        statusIconView.image = Assets.indicatorGoodBalanceIcon
        statusIconView.tintColor = DS.Colors.indicatorStatusPositive
        statusIconView.contentMode = .scaleAspectFit
        statusIconView.snp.makeConstraints {
            $0.size.equalTo(DS.Spacing.x16)
        }
    }

    func setupStatusLabel() {
        statusContainerView.addArrangedSubview(statusLabel)
        statusLabel.textColor = DS.Colors.indicatorStatusPositive
        statusLabel.font = DS.Font.regular(14)
        statusLabel.textAlignment = .center
    }

    func setupEmptyStackView() {
        ringContainerView.addSubview(emptyStackView)
        emptyStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x24)
        }
        emptyStackView.axis = .vertical
        emptyStackView.alignment = .center
        emptyStackView.spacing = DS.Spacing.x4
    }

    func setupEmptyTitleLabel() {
        emptyStackView.addArrangedSubview(emptyTitleLabel)
        emptyTitleLabel.textColor = DS.Colors.textSecondary
        emptyTitleLabel.font = DS.Font.bold(30)
        emptyTitleLabel.textAlignment = .center
    }

    func setupEmptySubtitleLabel() {
        emptyStackView.addArrangedSubview(emptySubtitleLabel)
        emptySubtitleLabel.textColor = DS.Colors.textTertiary
        emptySubtitleLabel.font = DS.Font.regular(14)
        emptySubtitleLabel.textAlignment = .center
    }
}
