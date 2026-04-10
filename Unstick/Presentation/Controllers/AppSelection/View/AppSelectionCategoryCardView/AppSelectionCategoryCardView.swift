//
//  AppSelectionCategoryCardView.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit
import SnapKit

final class AppSelectionCategoryCardView: UIView {
    private enum Layout {
        static let iconContainerSize = CGSize(width: 40, height: 40)
        static let iconSize = CGSize(width: 18, height: 18)
        static let chevronSize = CGSize(width: 18, height: 18)
        static let rowHeight: CGFloat = 56
    }

    private let contentContainerView = UIView()
    private let headerContainerView = UIView()
    private let iconContainerView = UIView()
    private let iconView = UIImageView()
    private let textStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let chevronView = UIImageView()
    private let appRowsContainerView = UIView()
    private let appRowsStackView = UIStackView()
    private let dividerView = UIView()

    private var dividerTopConstraint: Constraint?
    private var dividerHeightConstraint: Constraint?
    private var appRowsHeightConstraint: Constraint?
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

extension AppSelectionCategoryCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? AppSelectionCategoryCardModel else { return }

        iconView.image = UIImage(systemName: model.iconSystemName)
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        chevronView.image = UIImage(systemName: model.isExpanded ? "chevron.up" : "chevron.down")
        appRowsContainerView.isHidden = !model.isExpanded
        dividerView.isHidden = !model.isExpanded
        dividerTopConstraint?.update(offset: model.isExpanded ? DS.Spacing.x20 : 0)
        dividerHeightConstraint?.update(offset: model.isExpanded ? 1 : 0)
        appRowsHeightConstraint?.update(
            offset: model.isExpanded
                ? CGFloat(model.appRows.count) * Layout.rowHeight
                : 0
        )
        onTap = model.onTap
        applyAppRows(model.appRows)
    }
}

private extension AppSelectionCategoryCardView {
    func createUI() {
        setupSelf()
        setupContentContainerView()
        setupHeaderContainerView()
        setupIconContainerView()
        setupIconView()
        setupChevronView()
        setupTextStackView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupDividerView()
        setupAppRowsContainerView()
        setupAppRowsStackView()
        setupTapGesture()
    }

    func setupSelf() {
        backgroundColor = DS.Colors.surfacePrimary.withAlphaComponent(0.72)
        layer.cornerRadius = DS.CornerRadius.x32
        layer.borderWidth = 1
        layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.18).cgColor
        clipsToBounds = true
    }

    func setupContentContainerView() {
        addSubview(contentContainerView)
        contentContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(DS.Spacing.x16)
        }
    }

    func setupHeaderContainerView() {
        contentContainerView.addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
    }

    func setupIconContainerView() {
        headerContainerView.addSubview(iconContainerView)
        iconContainerView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(Layout.iconContainerSize)
            $0.top.greaterThanOrEqualToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
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
        iconView.tintColor = DS.Colors.textSecondary
        iconView.contentMode = .scaleAspectFit
    }

    func setupTextStackView() {
        headerContainerView.addSubview(textStackView)
        textStackView.snp.makeConstraints {
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(DS.Spacing.x12)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualTo(chevronView.snp.leading).offset(-DS.Spacing.x12)
        }
        textStackView.axis = .vertical
        textStackView.alignment = .leading
        textStackView.spacing = 2
    }

    func setupTitleLabel() {
        textStackView.addArrangedSubview(titleLabel)
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.bold(17)
        titleLabel.numberOfLines = 1
    }

    func setupSubtitleLabel() {
        textStackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.textColor = DS.Colors.textTertiary
        subtitleLabel.font = DS.Font.regular(13)
        subtitleLabel.numberOfLines = 1
    }

    func setupChevronView() {
        headerContainerView.addSubview(chevronView)
        chevronView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(Layout.chevronSize)
        }
        chevronView.tintColor = DS.Colors.textTertiary
        chevronView.contentMode = .scaleAspectFit
    }

    func setupDividerView() {
        contentContainerView.addSubview(dividerView)
        dividerView.snp.makeConstraints {
            dividerTopConstraint = $0.top.equalTo(headerContainerView.snp.bottom).offset(0).constraint
            $0.horizontalEdges.equalToSuperview()
            dividerHeightConstraint = $0.height.equalTo(0).constraint
        }
        dividerView.backgroundColor = DS.Colors.borderPrimary.withAlphaComponent(0.28)
        dividerView.isHidden = true
    }

    func setupAppRowsContainerView() {
        contentContainerView.addSubview(appRowsContainerView)
        appRowsContainerView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            appRowsHeightConstraint = $0.height.equalTo(0).constraint
        }
        appRowsContainerView.isHidden = true
    }

    func setupAppRowsStackView() {
        appRowsContainerView.addSubview(appRowsStackView)
        appRowsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        appRowsStackView.axis = .vertical
        appRowsStackView.spacing = 0
        appRowsStackView.alignment = .fill
        appRowsStackView.distribution = .fill
    }

    func applyAppRows(_ rows: [AppSelectionAppRowModel]) {
        appRowsStackView.arrangedSubviews.forEach { subview in
            appRowsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        for (index, row) in rows.enumerated() {
            let rowView = AppSelectionAppRowView()
            rowView.configure(
                with: row,
                showsSeparator: index < rows.count - 1
            )
            rowView.snp.makeConstraints {
                $0.height.equalTo(Layout.rowHeight)
            }
            appRowsStackView.addArrangedSubview(rowView)
        }
    }

    func setupTapGesture() {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        headerContainerView.addGestureRecognizer(gestureRecognizer)
    }

    @objc
    func handleTap() {
        onTap?()
    }
}
