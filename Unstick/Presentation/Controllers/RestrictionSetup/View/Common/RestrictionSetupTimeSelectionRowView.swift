//
//  RestrictionSetupTimeSelectionRowView.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit
import SnapKit

final class RestrictionSetupTimeSelectionRowView: UIView {
    private let titleLabel = UILabel()
    private let valueChipButton = UIButton(type: .system)
    private let valueLabel = UILabel()

    private var onTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension RestrictionSetupTimeSelectionRowView {
    func configure(
        title: String,
        value: String,
        isEnabled: Bool,
        onTap: (() -> Void)?
    ) {
        titleLabel.text = title
        valueLabel.text = value.uppercased()
        self.onTap = onTap

        alpha = isEnabled ? 1 : 0.52
        isUserInteractionEnabled = isEnabled
        valueChipButton.isUserInteractionEnabled = isEnabled
    }
}

private extension RestrictionSetupTimeSelectionRowView {
    func createUI() {
        setupSelf()
        setupTitleLabel()
        setupValueChipButton()
        setupValueLabel()
        setupTapAction()
    }

    func setupSelf() {
        backgroundColor = DS.Colors.neutral
        layer.cornerRadius = DS.CornerRadius.buttonExtraLarge
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(DS.Spacing.x20)
            $0.leading.equalToSuperview().offset(DS.Spacing.x24)
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.medium(16)
        titleLabel.numberOfLines = 1
    }

    func setupValueChipButton() {
        addSubview(valueChipButton)
        valueChipButton.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(DS.Spacing.x12)
            $0.trailing.equalToSuperview().inset(DS.Spacing.x24)
            $0.centerY.equalToSuperview()
        }
        valueChipButton.backgroundColor = DS.Colors.surfaceElevated
        valueChipButton.layer.cornerRadius = DS.CornerRadius.x16
    }

    func setupValueLabel() {
        valueChipButton.addSubview(valueLabel)
        valueLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
            $0.centerY.equalToSuperview()
        }
        valueLabel.textColor = DS.Colors.textSecondary
        valueLabel.font = DS.Font.medium(17)
        valueLabel.numberOfLines = 1
        valueLabel.textAlignment = .center
    }

    func setupTapAction() {
        let tapSelector = #selector(handleTap)
        let tapButton = UIButton(type: .custom)
        addSubview(tapButton)
        tapButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tapButton.backgroundColor = .clear
        tapButton.addTarget(self, action: tapSelector, for: .touchUpInside)
        valueChipButton.addTarget(self, action: tapSelector, for: .touchUpInside)
    }

    @objc
    func handleTap() {
        onTap?()
    }
}

