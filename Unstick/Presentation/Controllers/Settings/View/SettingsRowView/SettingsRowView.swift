//
//  SettingsRowView.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit
import SnapKit

final class SettingsRowView: UIView {
    private enum Layout {
        static let iconContainerSize = CGSize(width: 30, height: 30)
        static let iconSize = CGSize(width: 14, height: 14)
        static let switchScale: CGFloat = 0.84
    }

    private let iconContainerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let statusLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let toggleSwitch = UISwitch()
    private let separatorView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension SettingsRowView {
    func configure(
        with model: SettingsRowItemModel,
        showsSeparator: Bool
    ) {
        iconImageView.image = UIImage(systemName: model.iconSystemName)
        iconContainerView.backgroundColor = model.iconStyle.backgroundColor
        iconImageView.tintColor = model.iconStyle.tintColor
        titleLabel.text = model.title
        separatorView.isHidden = !showsSeparator

        switch model.accessory {
        case .chevron:
            statusLabel.isHidden = true
            chevronImageView.isHidden = false
            toggleSwitch.isHidden = true
        case .valueWithChevron(let value):
            statusLabel.isHidden = false
            statusLabel.text = value
            chevronImageView.isHidden = false
            toggleSwitch.isHidden = true
        case .value(let value):
            statusLabel.isHidden = false
            statusLabel.text = value
            chevronImageView.isHidden = true
            toggleSwitch.isHidden = true
        case .toggle(let isOn):
            statusLabel.isHidden = true
            chevronImageView.isHidden = true
            toggleSwitch.isHidden = false
            toggleSwitch.isOn = isOn
        }
    }
}

private extension SettingsRowView {
    func createUI() {
        setupSelf()
        setupIconContainerView()
        setupIconImageView()
        setupTitleLabel()
        setupStatusLabel()
        setupChevronImageView()
        setupToggleSwitch()
        setupSeparatorView()
    }

    func setupSelf() {
        backgroundColor = .clear
    }

    func setupIconContainerView() {
        addSubview(iconContainerView)
        iconContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(DS.Spacing.x24)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Layout.iconContainerSize)
        }
        iconContainerView.layer.cornerRadius = Layout.iconContainerSize.height / 2
    }

    func setupIconImageView() {
        iconContainerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.iconSize)
        }
        iconImageView.contentMode = .scaleAspectFit
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(DS.Spacing.x12)
            $0.centerY.equalToSuperview()
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.medium(15)
        titleLabel.numberOfLines = 1
    }

    func setupStatusLabel() {
        addSubview(statusLabel)
        statusLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(DS.Spacing.x12)
            $0.centerY.equalToSuperview()
        }
        statusLabel.textColor = DS.Colors.textTertiary
        statusLabel.font = DS.Font.regular(13)
        statusLabel.textAlignment = .right
        statusLabel.isHidden = true
    }

    func setupChevronImageView() {
        addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints {
            $0.leading.equalTo(statusLabel.snp.trailing).offset(DS.Spacing.x8)
            $0.trailing.equalToSuperview().inset(DS.Spacing.x24)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = DS.Colors.textTertiary.withAlphaComponent(0.72)
        chevronImageView.contentMode = .scaleAspectFit
    }

    func setupToggleSwitch() {
        addSubview(toggleSwitch)
        toggleSwitch.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(DS.Spacing.x12)
            $0.trailing.equalToSuperview().inset(DS.Spacing.x24)
            $0.centerY.equalToSuperview()
        }
        toggleSwitch.onTintColor = DS.Colors.primary
        toggleSwitch.transform = CGAffineTransform(scaleX: Layout.switchScale, y: Layout.switchScale)
        toggleSwitch.isUserInteractionEnabled = false
        toggleSwitch.isHidden = true
    }

    func setupSeparatorView() {
        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(DS.Spacing.x24)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        separatorView.backgroundColor = DS.Colors.borderPrimary.withAlphaComponent(0.32)
    }
}
