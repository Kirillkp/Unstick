//
//  GroupDetailsStatusControlCardView.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit
import SnapKit

final class GroupDetailsStatusControlCardView: UIView {
    private enum Layout {
        static let statusDotSize = CGSize(width: 10, height: 10)
        static let statusButtonHeight: CGFloat = 40
    }

    private let cardView = UIView()
    private let headerStackView = UIStackView()
    private let statusRowStackView = UIStackView()
    private let statusDotView = UIView()
    private let statusLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    private let subtitleLabel = UILabel()

    private var onTapAction: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension GroupDetailsStatusControlCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? GroupDetailsStatusControlCardModel else { return }

        statusLabel.text = model.title
        subtitleLabel.text = model.subtitle
        actionButton.setTitle(model.actionTitle, for: .normal)
        onTapAction = model.onTapAction
        actionButton.isEnabled = model.isActionEnabled
        actionButton.alpha = model.isActionEnabled ? 1 : 0.72

        statusDotView.backgroundColor = model.isActive
            ? DS.Colors.indicatorStatusSoftPositive
            : DS.Colors.borderDanger
    }
}

private extension GroupDetailsStatusControlCardView {
    func createUI() {
        setupSelf()
        setupCardView()
        setupHeaderStackView()
        setupStatusRowStackView()
        setupStatusDotView()
        setupStatusLabel()
        setupActionButton()
        setupSubtitleLabel()
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

    func setupHeaderStackView() {
        cardView.addSubview(headerStackView)
        headerStackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
        }
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = DS.Spacing.x12
    }

    func setupStatusRowStackView() {
        headerStackView.addArrangedSubview(statusRowStackView)
        statusRowStackView.axis = .horizontal
        statusRowStackView.alignment = .center
        statusRowStackView.spacing = DS.Spacing.x8
        statusRowStackView.setContentHuggingPriority(.required, for: .horizontal)
        statusRowStackView.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    func setupStatusDotView() {
        statusRowStackView.addArrangedSubview(statusDotView)
        statusDotView.snp.makeConstraints {
            $0.size.equalTo(Layout.statusDotSize)
        }
        statusDotView.layer.cornerRadius = Layout.statusDotSize.width / 2
    }

    func setupStatusLabel() {
        statusRowStackView.addArrangedSubview(statusLabel)
        statusLabel.textColor = DS.Colors.indicatorStatusSoftPositive
        statusLabel.font = DS.Font.semiBold(14)
        statusLabel.numberOfLines = 1
    }

    func setupActionButton() {
        headerStackView.addArrangedSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.height.equalTo(Layout.statusButtonHeight)
        }
        actionButton.backgroundColor = DS.Colors.surfaceElevated
        actionButton.layer.cornerRadius = Layout.statusButtonHeight / 2
        actionButton.contentEdgeInsets = .init(horizontal: DS.Spacing.x16)
        actionButton.setTitleColor(DS.Colors.textSecondary, for: .normal)
        actionButton.titleLabel?.font = DS.Font.semiBold(12)
        actionButton.addTarget(self, action: #selector(handleTapAction), for: .touchUpInside)
    }

    func setupSubtitleLabel() {
        cardView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(DS.Spacing.x10)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
            $0.bottom.equalToSuperview().inset(DS.Spacing.x20)
        }
        subtitleLabel.textColor = DS.Colors.textTertiary
        subtitleLabel.font = DS.Font.regular(14)
        subtitleLabel.numberOfLines = 0
    }

    @objc
    func handleTapAction() {
        onTapAction?()
    }
}
