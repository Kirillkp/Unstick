//
//  GroupDetailsAppsListCardView.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit
import SnapKit

final class GroupDetailsAppsListCardView: UIView {
    private enum Layout {
        static let iconContainerSize = CGSize(width: 44, height: 44)
        static let iconSize = CGSize(width: 22, height: 22)
        static let rowHeight: CGFloat = 64
    }

    private let cardView = UIView()
    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension GroupDetailsAppsListCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? GroupDetailsAppsListCardModel else { return }
        applyRows(model.rows)
    }
}

private extension GroupDetailsAppsListCardView {
    func createUI() {
        setupSelf()
        setupCardView()
        setupStackView()
    }

    func setupSelf() {
        backgroundColor = .clear
    }

    func setupCardView() {
        addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        cardView.backgroundColor = DS.Colors.surfacePrimary.withAlphaComponent(0.72)
        cardView.layer.cornerRadius = DS.CornerRadius.x32
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.18).cgColor
        cardView.clipsToBounds = true
    }

    func setupStackView() {
        cardView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Spacing.x12)
        }
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
    }

    func applyRows(_ rows: [GroupDetailsAppsListCardModel.Row]) {
        stackView.arrangedSubviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        for (index, row) in rows.enumerated() {
            let rowView = RowView()
            rowView.configure(
                row: row,
                showsSeparator: index < rows.count - 1
            )
            rowView.snp.makeConstraints {
                $0.height.equalTo(Layout.rowHeight)
            }
            stackView.addArrangedSubview(rowView)
        }
    }
}

private extension GroupDetailsAppsListCardView {
    final class RowView: UIView {
        private enum Layout {
            static let iconContainerSize = CGSize(width: 44, height: 44)
            static let iconSize = CGSize(width: 22, height: 22)
        }

        private let iconContainerView = UIView()
        private let iconView = UIImageView()
        private let titleLabel = UILabel()
        private let usageLabel = UILabel()
        private let separatorView = UIView()

        override init(frame: CGRect) {
            super.init(frame: frame)
            createUI()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            createUI()
        }

        func configure(
            row: GroupDetailsAppsListCardModel.Row,
            showsSeparator: Bool
        ) {
            iconView.image = row.icon
            titleLabel.text = row.name
            usageLabel.text = row.usageText
            separatorView.isHidden = !showsSeparator
        }
    }
}

private extension GroupDetailsAppsListCardView.RowView {
    func createUI() {
        setupSelf()
        setupIconContainerView()
        setupIconView()
        setupUsageLabel()
        setupTitleLabel()
        setupSeparatorView()
    }

    func setupSelf() {
        backgroundColor = .clear
    }

    func setupIconContainerView() {
        addSubview(iconContainerView)
        iconContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(DS.Spacing.x8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Layout.iconContainerSize)
        }
        iconContainerView.backgroundColor = DS.Colors.surfaceElevated.withAlphaComponent(0.72)
        iconContainerView.layer.cornerRadius = Layout.iconContainerSize.width / 2
    }

    func setupIconView() {
        iconContainerView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.iconSize)
        }
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = DS.Colors.textSecondary
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(DS.Spacing.x12)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(usageLabel.snp.leading).offset(-DS.Spacing.x12)
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.applyFontStyle(.body)
        titleLabel.numberOfLines = 1
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    func setupUsageLabel() {
        addSubview(usageLabel)
        usageLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(DS.Spacing.x8)
            $0.centerY.equalToSuperview()
        }
        usageLabel.textColor = DS.Colors.textTertiary
        usageLabel.applyFontStyle(.body)
        usageLabel.textAlignment = .right
        usageLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        usageLabel.setContentHuggingPriority(.required, for: .horizontal)
    }

    func setupSeparatorView() {
        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(DS.Spacing.x8)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        separatorView.backgroundColor = DS.Colors.borderPrimary.withAlphaComponent(0.28)
    }
}
