//
//  UsageSummaryCardView.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import UIKit
import SnapKit

final class UsageSummaryCardView: UIView {
    private enum Layout {
        static let iconSize = CGSize(width: 32, height: 32)
        static let iconImageSize = CGSize(width: 18, height: 18)
        static let warningIconSize = CGSize(width: 16, height: 16)
        static let progressHeight: CGFloat = 12
        static let iconOverlap: CGFloat = 20
    }

    private let overlayView = UIView()
    private let overlayGradientLayer = CAGradientLayer()
    private let headerContainerView = UIView()
    private let textContainerView = UIView()
    private let titleRowStackView = UIStackView()
    private let titleLabel = UILabel()
    private let warningIconView = UIImageView()
    private let subtitleLabel = UILabel()
    private let trailingIconsContainerView = UIView()
    private let progressTrackView = UIView()
    private let progressFillView = UIView()
    private let progressGradientLayer = CAGradientLayer()

    private var progressWidthConstraint: Constraint?
    private var trailingIconsWidthConstraint: Constraint?
    private var iconViews: [UIView] = []
    private var onTap: (() -> Void)?

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
        overlayGradientLayer.frame = overlayView.bounds
        progressGradientLayer.frame = progressFillView.bounds
        progressGradientLayer.cornerRadius = progressFillView.bounds.height / 2
    }
}

extension UsageSummaryCardView {
    func configure(_ model: UsageSummaryCardModel) {
        applyStyle(model.style)
        applyText(model)
        applyProgress(model)
        applyIcons(model)
        onTap = model.onTap
    }
}

extension UsageSummaryCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? UsageSummaryCardModel else { return }
        configure(model)
    }
}

private extension UsageSummaryCardView {
    struct StyleAppearance {
        let backgroundColor: UIColor
        let borderColor: UIColor
        let subtitleColor: UIColor
        let progressColors: [UIColor]

        var progressShadowColor: UIColor {
            progressColors.first?.withAlphaComponent(0.45) ?? .clear
        }
    }

    func createUI() {
        setupSelf()
        setupOverlayView()
        setupHeaderContainerView()
        setupTextContainerView()
        setupTitleRowStackView()
        setupTitleLabel()
        setupWarningIconView()
        setupSubtitleLabel()
        setupTrailingIconsContainerView()
        setupProgressTrackView()
        setupProgressFillView()
        setupTapGesture()
    }

    func setupSelf() {
        layer.cornerRadius = DS.CornerRadius.x32
        layer.borderWidth = 1
        clipsToBounds = true
    }

    func setupOverlayView() {
        addSubview(overlayView)
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        overlayView.isHidden = true
        overlayView.alpha = 0
        overlayView.isUserInteractionEnabled = false
        overlayView.layer.insertSublayer(overlayGradientLayer, at: 0)

        overlayGradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        overlayGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        overlayGradientLayer.locations = [0.58, 1]
        overlayGradientLayer.colors = [
            UIColor.clear.cgColor,
            DS.Colors.borderDanger.withAlphaComponent(0.1).cgColor
        ]
    }

    func setupHeaderContainerView() {
        addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(DS.Spacing.x24)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x24)
        }
    }

    func setupTextContainerView() {
        headerContainerView.addSubview(textContainerView)
        textContainerView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview().offset(-92)
        }
    }

    func setupTitleRowStackView() {
        textContainerView.addSubview(titleRowStackView)
        titleRowStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        titleRowStackView.axis = .horizontal
        titleRowStackView.alignment = .center
        titleRowStackView.spacing = DS.Spacing.x8
    }

    func setupTitleLabel() {
        titleRowStackView.addArrangedSubview(titleLabel)
        titleLabel.textColor = DS.Colors.textPrimary
        titleLabel.font = DS.Font.bold(18)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    func setupWarningIconView() {
        titleRowStackView.addArrangedSubview(warningIconView)
        warningIconView.snp.makeConstraints {
            $0.size.equalTo(Layout.warningIconSize)
        }
        warningIconView.contentMode = .scaleAspectFit
        warningIconView.tintColor = DS.Colors.textDanger
        warningIconView.image = UIImage(systemName: "exclamationmark.triangle")
        warningIconView.setContentHuggingPriority(.required, for: .horizontal)
        warningIconView.setContentCompressionResistancePriority(.required, for: .horizontal)
        warningIconView.isHidden = true
    }

    func setupSubtitleLabel() {
        textContainerView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleRowStackView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        subtitleLabel.font = DS.Font.regular(14)
        subtitleLabel.numberOfLines = 1
    }

    func setupTrailingIconsContainerView() {
        headerContainerView.addSubview(trailingIconsContainerView)
        trailingIconsContainerView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(Layout.iconSize.height)
            trailingIconsWidthConstraint = $0.width.equalTo(0).constraint
            $0.leading.greaterThanOrEqualTo(textContainerView.snp.trailing).offset(DS.Spacing.x12)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }

    func setupProgressTrackView() {
        addSubview(progressTrackView)
        progressTrackView.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom).offset(DS.Spacing.x24)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x24)
            $0.bottom.equalToSuperview().inset(DS.Spacing.x24)
            $0.height.equalTo(Layout.progressHeight)
        }
        progressTrackView.backgroundColor = DS.Colors.usageCardProgressTrack
        progressTrackView.layer.cornerRadius = DS.CornerRadius.x6
        progressTrackView.clipsToBounds = true
    }

    func setupProgressFillView() {
        progressTrackView.addSubview(progressFillView)
        progressFillView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            progressWidthConstraint = $0.width.equalTo(0).constraint
        }
        progressFillView.layer.cornerRadius = DS.CornerRadius.x6
        progressFillView.clipsToBounds = true
        progressFillView.layer.insertSublayer(progressGradientLayer, at: 0)

        progressGradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        progressGradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    }

    func setupTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
    }

    func applyStyle(_ style: UsageSummaryCardModel.Style) {
        let appearance = makeStyleAppearance(for: style)

        backgroundColor = appearance.backgroundColor
        layer.borderColor = appearance.borderColor.cgColor
        subtitleLabel.textColor = appearance.subtitleColor

        overlayView.isHidden = style != .danger
        overlayView.alpha = style == .danger ? 1 : 0

        progressGradientLayer.colors = appearance.progressColors.map(\.cgColor)
        progressFillView.layer.shadowColor = appearance.progressShadowColor.cgColor
        progressFillView.layer.shadowOpacity = 1
        progressFillView.layer.shadowRadius = DS.Spacing.x12
        progressFillView.layer.shadowOffset = .zero
    }

    func applyText(_ model: UsageSummaryCardModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        warningIconView.isHidden = !model.showsWarningIcon
    }

    func applyProgress(_ model: UsageSummaryCardModel) {
        layoutIfNeeded()
        let progressWidth = progressTrackView.bounds.width * model.progress
        progressWidthConstraint?.update(offset: progressWidth)
        setNeedsLayout()
        layoutIfNeeded()
    }

    func applyIcons(_ model: UsageSummaryCardModel) {
        iconViews.forEach { $0.removeFromSuperview() }
        iconViews.removeAll()

        var currentX: CGFloat = 0
        let visibleIcons = Array(model.appIcons.prefix(3))

        for (index, icon) in visibleIcons.enumerated() {
            let iconView = makeAppIconView(image: icon.image)
            trailingIconsContainerView.addSubview(iconView)
            iconView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(currentX)
                $0.top.bottom.equalToSuperview()
                $0.size.equalTo(Layout.iconSize)
            }
            iconView.layer.zPosition = CGFloat(visibleIcons.count - index)
            iconViews.append(iconView)
            currentX += Layout.iconOverlap
        }

        if let extraCount = model.extraCount {
            let countView = makeExtraCountView(count: extraCount)
            trailingIconsContainerView.addSubview(countView)
            countView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(currentX)
                $0.top.bottom.equalToSuperview()
                $0.size.equalTo(Layout.iconSize)
                $0.trailing.equalToSuperview()
            }
            countView.layer.zPosition = 1
            iconViews.append(countView)
        } else if let lastView = iconViews.last {
            lastView.snp.makeConstraints {
                $0.trailing.equalToSuperview()
            }
        }

        let width: CGFloat
        if iconViews.isEmpty {
            width = 0
        } else if model.extraCount != nil {
            width = currentX + Layout.iconSize.width
        } else {
            width = currentX + DS.Spacing.x12
        }

        trailingIconsWidthConstraint?.update(offset: width)
    }

    func makeAppIconView(image: UIImage?) -> UIView {
        let containerView = UIView()
        let imageView = UIImageView(image: image)

        containerView.backgroundColor = DS.Colors.usageCardIconBackground
        containerView.layer.cornerRadius = DS.CornerRadius.x16
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.2).cgColor

        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.iconImageSize)
        }
        imageView.contentMode = .scaleAspectFit

        return containerView
    }

    func makeExtraCountView(count: Int) -> UIView {
        let containerView = UIView()
        let label = UILabel()

        containerView.backgroundColor = DS.Colors.usageCardIconBackground
        containerView.layer.cornerRadius = DS.CornerRadius.x16
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.2).cgColor

        containerView.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        label.text = "+\(count)"
        label.textColor = DS.Colors.textSecondary
        label.font = DS.Font.semiBold(10)
        label.textAlignment = .center

        return containerView
    }

    func makeStyleAppearance(for style: UsageSummaryCardModel.Style) -> StyleAppearance {
        switch style {
        case .primary:
            return .init(
                backgroundColor: DS.Colors.surfacePrimary.withAlphaComponent(0.4),
                borderColor: DS.Colors.borderPrimary.withAlphaComponent(0.2),
                subtitleColor: DS.Colors.textTertiary,
                progressColors: [
                    DS.Colors.usageCardProgressPrimaryStart,
                    DS.Colors.usageCardProgressPrimaryEnd
                ]
            )
        case .warning:
            return .init(
                backgroundColor: DS.Colors.surfacePrimary.withAlphaComponent(0.4),
                borderColor: DS.Colors.borderPrimary.withAlphaComponent(0.2),
                subtitleColor: DS.Colors.textTertiary,
                progressColors: [
                    DS.Colors.usageCardProgressWarningStart,
                    DS.Colors.usageCardProgressWarningEnd
                ]
            )
        case .danger:
            return .init(
                backgroundColor: DS.Colors.backgroundDanger.withAlphaComponent(0.05),
                borderColor: DS.Colors.borderDanger.withAlphaComponent(0.2),
                subtitleColor: DS.Colors.textDanger,
                progressColors: [
                    DS.Colors.usageCardProgressDangerStart,
                    DS.Colors.usageCardProgressDangerEnd
                ]
            )
        }
    }

    @objc
    func handleTap() {
        onTap?()
    }
}
