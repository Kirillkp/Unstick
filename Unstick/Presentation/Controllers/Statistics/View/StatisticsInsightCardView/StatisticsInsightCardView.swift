//
//  StatisticsInsightCardView.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit
import SnapKit

final class StatisticsInsightCardView: UIView {
    private enum Layout {
        static let iconContainerSize = CGSize(width: 30, height: 30)
        static let iconSize = CGSize(width: 14, height: 14)
    }

    private let iconContainerView = UIView()
    private let iconImageView = UIImageView()
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension StatisticsInsightCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? StatisticsInsightCardModel else { return }

        iconImageView.image = UIImage(systemName: model.iconSystemName)
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        applyStyle(model.style)
    }
}

private extension StatisticsInsightCardView {
    func createUI() {
        setupSelf()
        setupIconContainerView()
        setupIconImageView()
        setupTextStackView()
        setupTitleLabel()
        setupSubtitleLabel()
    }

    func setupSelf() {
        backgroundColor = DS.Colors.surfacePrimary.withAlphaComponent(0.72)
        layer.cornerRadius = DS.CornerRadius.x32
        layer.borderWidth = 1
        layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.24).cgColor
    }

    func setupIconContainerView() {
        addSubview(iconContainerView)
        iconContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(DS.Spacing.x16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Layout.iconContainerSize)
        }
        iconContainerView.backgroundColor = DS.Colors.surfaceElevated
        iconContainerView.layer.cornerRadius = Layout.iconContainerSize.height / 2
        iconContainerView.layer.borderWidth = 1
        iconContainerView.layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.24).cgColor
    }

    func setupIconImageView() {
        iconContainerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.iconSize)
        }
        iconImageView.contentMode = .scaleAspectFit
    }

    func setupTextStackView() {
        addSubview(textStackView)
        textStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(DS.Spacing.x16)
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(DS.Spacing.x12)
            $0.trailing.equalToSuperview().inset(DS.Spacing.x16)
        }
        textStackView.axis = .vertical
        textStackView.spacing = DS.Spacing.x4
        textStackView.alignment = .fill
    }

    func setupTitleLabel() {
        textStackView.addArrangedSubview(titleLabel)
        titleLabel.font = DS.Font.semiBold(14)
        titleLabel.numberOfLines = 1
    }

    func setupSubtitleLabel() {
        textStackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.font = DS.Font.regular(11)
        subtitleLabel.numberOfLines = 2
    }

    func applyStyle(_ style: StatisticsInsightCardModel.Style) {
        switch style {
        case .primary:
            iconImageView.tintColor = DS.Colors.primary
            titleLabel.textColor = DS.Colors.textSecondary
            subtitleLabel.textColor = DS.Colors.textTertiary
        case .neutral:
            iconImageView.tintColor = DS.Colors.textTertiary
            titleLabel.textColor = DS.Colors.textSecondary
            subtitleLabel.textColor = DS.Colors.textTertiary
        }
    }
}
