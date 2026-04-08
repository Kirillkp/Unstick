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
    private let headingStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let actionStackView = UIStackView()
    private let actionButton = DSButton()
    private let noteContainerView = UIView()
    private let noteStackView = UIStackView()
    private let noteIconView = UIImageView()
    private let noteLabel = UILabel()

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
        setupHeadingStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupActionStackView()
        setupActionButton()
        setupNoteContainerView()
        setupNoteStackView()
        setupNoteIconView()
        setupNoteLabel()
    }

    func setupContentStackView() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentStackView.axis = .vertical
        contentStackView.alignment = .fill
        contentStackView.spacing = DS.Spacing.x32
    }

    func setupHeadingStackView() {
        contentStackView.addArrangedSubview(headingStackView)
        headingStackView.axis = .vertical
        headingStackView.alignment = .fill
        headingStackView.spacing = DS.Spacing.x12
    }

    func setupTitleLabel() {
        headingStackView.addArrangedSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.extraBold(24)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
    }

    func setupSubtitleLabel() {
        headingStackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x32)
        }
        subtitleLabel.textColor = DS.Colors.textTertiary
        subtitleLabel.font = DS.Font.regular(16)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textAlignment = .center
    }

    func setupActionStackView() {
        contentStackView.addArrangedSubview(actionStackView)
        actionStackView.axis = .vertical
        actionStackView.alignment = .fill
        actionStackView.spacing = DS.Spacing.x16
    }

    func setupActionButton() {
        actionStackView.addArrangedSubview(actionButton)
        actionButton.setStyle(.primary, size: .xl)
        actionButton.addTarget(
            self,
            action: #selector(didTapActionButton),
            for: .touchUpInside
        )
    }

    func setupNoteContainerView() {
        actionStackView.addArrangedSubview(noteContainerView)
    }

    func setupNoteStackView() {
        noteContainerView.addSubview(noteStackView)
        noteStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        noteStackView.axis = .horizontal
        noteStackView.alignment = .center
        noteStackView.spacing = DS.Spacing.x8
        noteStackView.setContentHuggingPriority(.required, for: .horizontal)
        noteStackView.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    func setupNoteIconView() {
        noteStackView.addArrangedSubview(noteIconView)
        noteIconView.snp.makeConstraints {
            $0.size.equalTo(Layout.noteIconSize)
        }
        noteIconView.image = UIImage(systemName: "info.circle.fill")
        noteIconView.tintColor = DS.Colors.textTertiary.withAlphaComponent(0.6)
        noteIconView.contentMode = .scaleAspectFit
    }

    func setupNoteLabel() {
        noteStackView.addArrangedSubview(noteLabel)
        noteLabel.textColor = DS.Colors.textTertiary.withAlphaComponent(0.6)
        noteLabel.font = DS.Font.medium(12)
        noteLabel.textAlignment = .center
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
        noteLabel.text = model.note
    }
}
