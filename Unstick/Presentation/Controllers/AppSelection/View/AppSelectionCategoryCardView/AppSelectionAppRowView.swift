//
//  AppSelectionAppRowView.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit
import SnapKit

final class AppSelectionAppRowView: UIView {
    private enum Layout {
        static let iconContainerSize = CGSize(width: 36, height: 36)
        static let iconSize = CGSize(width: 18, height: 18)
        static let selectionSize = CGSize(width: 24, height: 24)
    }

    private let iconContainerView = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let selectionView = UIView()
    private let selectionImageView = UIImageView()
    private let separatorView = UIView()
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

extension AppSelectionAppRowView {
    func configure(
        with model: AppSelectionAppRowModel,
        showsSeparator: Bool
    ) {
        iconView.image = UIImage(systemName: model.iconSystemName)
        titleLabel.text = model.title
        separatorView.isHidden = !showsSeparator
        onTap = model.onTap

        selectionView.backgroundColor = model.isSelected
            ? DS.Colors.tertiary
            : .clear
        selectionView.layer.borderWidth = model.isSelected ? 0 : 1
        selectionView.layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.28).cgColor
        selectionImageView.image = UIImage(systemName: model.isSelected ? "checkmark" : "")
        selectionImageView.tintColor = DS.Colors.neutral
    }
}

private extension AppSelectionAppRowView {
    func createUI() {
        setupSelf()
        setupIconContainerView()
        setupIconView()
        setupSelectionView()
        setupTitleLabel()
        setupSelectionImageView()
        setupSeparatorView()
        setupTapGesture()
    }

    func setupSelf() {
        backgroundColor = .clear
    }

    func setupIconContainerView() {
        addSubview(iconContainerView)
        iconContainerView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Layout.iconContainerSize)
        }
        iconContainerView.backgroundColor = DS.Colors.surfaceElevated
        iconContainerView.layer.cornerRadius = Layout.iconContainerSize.width / 2
    }

    func setupIconView() {
        iconContainerView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.iconSize)
        }
        iconView.tintColor = DS.Colors.textSecondary
        iconView.contentMode = .scaleAspectFit
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(DS.Spacing.x12)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(selectionView.snp.leading).offset(-DS.Spacing.x12)
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.regular(17)
        titleLabel.numberOfLines = 1
    }

    func setupSelectionView() {
        addSubview(selectionView)
        selectionView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Layout.selectionSize)
        }
        selectionView.layer.cornerRadius = Layout.selectionSize.width / 2
    }

    func setupSelectionImageView() {
        selectionView.addSubview(selectionImageView)
        selectionImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        selectionImageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(
            pointSize: 12,
            weight: .bold
        )
        selectionImageView.contentMode = .scaleAspectFit
    }

    func setupSeparatorView() {
        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        separatorView.backgroundColor = DS.Colors.borderPrimary.withAlphaComponent(0.28)
    }

    func setupTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func handleTap() {
        onTap?()
    }
}
