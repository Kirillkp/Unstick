//
//  GroupDetailsUsageSummaryCardView.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit
import SnapKit

final class GroupDetailsUsageSummaryCardView: UIView {
    private enum Layout {
        static let progressHeight: CGFloat = 12
    }

    private let cardView = UIView()
    private let titleLabel = UILabel()
    private let valueStackView = UIStackView()
    private let valueLabel = UILabel()
    private let limitLabel = UILabel()
    private let progressTrackView = UIView()
    private let progressFillView = UIView()

    private var progressWidthConstraint: Constraint?
    private var currentProgress: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateProgressWidth()
    }
}

extension GroupDetailsUsageSummaryCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? GroupDetailsUsageSummaryCardModel else { return }

        titleLabel.text = model.title
        valueLabel.text = model.valueText
        limitLabel.text = model.limitText

        currentProgress = model.progress
        updateProgressWidth()
    }
}

private extension GroupDetailsUsageSummaryCardView {
    func createUI() {
        setupSelf()
        setupCardView()
        setupTitleLabel()
        setupValueStackView()
        setupValueLabel()
        setupLimitLabel()
        setupProgressTrackView()
        setupProgressFillView()
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
        cardView.layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.24).cgColor
    }

    func setupTitleLabel() {
        cardView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
        }
        titleLabel.textColor = DS.Colors.textTertiary
        titleLabel.font = DS.Font.bold(12)
        titleLabel.numberOfLines = 1
    }

    func setupValueStackView() {
        cardView.addSubview(valueStackView)
        valueStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(DS.Spacing.x4)
            $0.leading.equalToSuperview().inset(DS.Spacing.x20)
            $0.trailing.lessThanOrEqualToSuperview().inset(DS.Spacing.x20)
        }
        valueStackView.axis = .horizontal
        valueStackView.alignment = .lastBaseline
        valueStackView.spacing = DS.Spacing.x8
        valueStackView.distribution = .fill
    }

    func setupValueLabel() {
        valueStackView.addArrangedSubview(valueLabel)
        valueLabel.textColor = DS.Colors.textSecondary
        valueLabel.font = DS.Font.extraBold(30)
        valueLabel.numberOfLines = 1
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    func setupLimitLabel() {
        valueStackView.addArrangedSubview(limitLabel)
        limitLabel.textColor = DS.Colors.textTertiary
        limitLabel.font = DS.Font.regular(14)
        limitLabel.numberOfLines = 1
        limitLabel.setContentHuggingPriority(.required, for: .horizontal)
        limitLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    func setupProgressTrackView() {
        cardView.addSubview(progressTrackView)
        progressTrackView.snp.makeConstraints {
            $0.top.equalTo(valueStackView.snp.bottom).offset(DS.Spacing.x16)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
            $0.height.equalTo(Layout.progressHeight)
            $0.bottom.equalToSuperview().inset(DS.Spacing.x20)
        }
        progressTrackView.backgroundColor = DS.Colors.surfaceElevated
        progressTrackView.layer.cornerRadius = Layout.progressHeight / 2
        progressTrackView.clipsToBounds = true
    }

    func setupProgressFillView() {
        progressTrackView.addSubview(progressFillView)
        progressFillView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            progressWidthConstraint = $0.width.equalTo(0).constraint
        }
        progressFillView.backgroundColor = DS.Colors.primary
        progressFillView.layer.cornerRadius = Layout.progressHeight / 2
    }

    func updateProgressWidth() {
        let progressWidth = progressTrackView.bounds.width * currentProgress
        progressWidthConstraint?.update(offset: progressWidth)
    }
}
