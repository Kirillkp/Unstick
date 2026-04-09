//
//  StatisticsMetricCardView.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit
import SnapKit

final class StatisticsMetricCardView: UIView {
    private enum Layout {
        static let iconContainerSize = CGSize(width: 40, height: 40)
        static let iconSize = CGSize(width: 20, height: 20)
    }

    private let iconContainerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension StatisticsMetricCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? StatisticsMetricCardModel else { return }

        iconImageView.image = UIImage(systemName: model.iconSystemName)
        titleLabel.text = model.title.uppercased()
        valueLabel.text = model.value
    }
}

private extension StatisticsMetricCardView {
    func createUI() {
        setupSelf()
        setupIconContainerView()
        setupIconImageView()
        setupTitleLabel()
        setupValueLabel()
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
            $0.top.leading.equalToSuperview().inset(DS.Spacing.x16)
            $0.size.equalTo(Layout.iconContainerSize)
            $0.height.equalTo(Layout.iconContainerSize.height)
        }
        iconContainerView.backgroundColor = DS.Colors.surfaceElevated
        iconContainerView.layer.cornerRadius = Layout.iconContainerSize.height / 2
        iconContainerView.layer.borderWidth = 1
        iconContainerView.layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.28).cgColor
    }

    func setupIconImageView() {
        iconContainerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.iconSize)
        }
        iconImageView.tintColor = DS.Colors.tertiary
        iconImageView.contentMode = .scaleAspectFit
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(iconContainerView.snp.bottom).offset(DS.Spacing.x16)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
        }
        titleLabel.textColor = DS.Colors.textTertiary
        titleLabel.font = DS.Font.medium(10)
        titleLabel.numberOfLines = 1
    }

    func setupValueLabel() {
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview().inset(DS.Spacing.x16)
        }
        valueLabel.textColor = DS.Colors.textSecondary
        valueLabel.font = DS.Font.bold(28)
        valueLabel.numberOfLines = 1
    }
}
