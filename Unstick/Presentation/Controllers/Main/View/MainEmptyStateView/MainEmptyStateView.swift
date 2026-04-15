//
//  MainEmptyStateView.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit
import SnapKit

final class MainEmptyStateView: UIView {
    private enum Layout {
        static let noteIconSize: CGFloat = 15
    }

    var onDidTapActionButton: (() -> Void)?

    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionButton = DSButton()

    override init(frame: CGRect) {
        super.init(frame: frame)

        createUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MainEmptyStateView {
    func createUI() {
        setupContentStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupActionButton()
    }

    func setupContentStackView() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentStackView.axis = .vertical
        contentStackView.alignment = .center
        contentStackView.spacing = DS.Spacing.x16
    }

    func setupTitleLabel() {
        contentStackView.addArrangedSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.extraBold(24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        contentStackView.setCustomSpacing(DS.Spacing.x12, after: titleLabel)
    }

    func setupSubtitleLabel() {
        contentStackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
        }
        subtitleLabel.textColor = DS.Colors.textTertiary
        subtitleLabel.font = DS.Font.regular(16)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        contentStackView.setCustomSpacing(DS.Spacing.x32, after: subtitleLabel)
    }

    func setupActionButton() {
        contentStackView.addArrangedSubview(actionButton)
        actionButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
        }
        actionButton.setStyle(.primary, size: .xl)
        actionButton.addTarget(
            self,
            action: #selector(didTapActionButton),
            for: .touchUpInside
        )
        contentStackView.setCustomSpacing(DS.Spacing.x12, after: actionButton)
    }

    @objc
    func didTapActionButton() {
        onDidTapActionButton?()
    }
}

extension MainEmptyStateView {
    func configure(_ model: MainEmptyStateModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        actionButton.setTitle(model.actionTitle, for: .normal)
        actionButton.setStyle(.primary, size: .xl)
        actionButton.setImage(nil, for: .normal)
    }
}

extension MainEmptyStateView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? MainEmptyStateModel else { return }
        configure(model)
        onDidTapActionButton = model.onTapAction
    }
}
