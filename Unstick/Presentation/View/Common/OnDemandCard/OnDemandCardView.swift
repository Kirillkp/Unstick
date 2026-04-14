//
//  OnDemandCardView.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit
import SnapKit

final class OnDemandCardView: UIView {
    private enum Layout {
        static let iconContainerSize = CGSize(width: 40, height: 40)
        static let iconSize = CGSize(width: 18, height: 18)
        static let switchScale: CGFloat = 0.84
    }

    private let cardView = UIView()
    private let headerContainerView = UIView()
    private let iconContainerView = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let featureSwitch = UISwitch()
    private let subtitleLabel = UILabel()
    private let extraTimeRowView = RestrictionSetupTimeSelectionRowView()

    private var minuteOptions: [Int] = []
    private var selectedMinute = 0
    private var onToggleChanged: ((Bool) -> Void)?
    private var onExtraTimeSelected: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension OnDemandCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? OnDemandCardModel else { return }

        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        featureSwitch.isOn = model.isEnabled
        minuteOptions = model.minuteOptions
        selectedMinute = model.extraTimeSelectedMinute
        onToggleChanged = model.onToggleChanged
        onExtraTimeSelected = model.onExtraTimeSelected

        subtitleLabel.alpha = model.isEnabled ? 1 : 0.52
        extraTimeRowView.configure(
            title: model.extraTimeTitle,
            value: model.extraTimeValue,
            isEnabled: model.isEnabled
        ) { [weak self] in
            self?.showExtraTimePopover()
        }
    }
}

private extension OnDemandCardView {
    func createUI() {
        setupSelf()
        setupCardView()
        setupHeaderContainerView()
        setupIconContainerView()
        setupIconView()
        setupTitleLabel()
        setupFeatureSwitch()
        setupSubtitleLabel()
        setupExtraTimeRowView()
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
    }

    func setupHeaderContainerView() {
        cardView.addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
            $0.height.equalTo(Layout.iconContainerSize.height)
        }
    }

    func setupIconContainerView() {
        headerContainerView.addSubview(iconContainerView)
        iconContainerView.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(Layout.iconContainerSize)
        }
        iconContainerView.backgroundColor = UIColor.hex("#3B4A2E")
        iconContainerView.layer.cornerRadius = Layout.iconContainerSize.width / 2
    }

    func setupIconView() {
        iconContainerView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.iconSize)
        }
        iconView.image = UIImage(systemName: "lock")
        iconView.tintColor = DS.Colors.indicatorStatusPositive
        iconView.contentMode = .scaleAspectFit
    }

    func setupTitleLabel() {
        headerContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(DS.Spacing.x12)
            $0.centerY.equalToSuperview()
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.bold(17)
        titleLabel.numberOfLines = 1
    }

    func setupFeatureSwitch() {
        headerContainerView.addSubview(featureSwitch)
        featureSwitch.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(DS.Spacing.x12)
            $0.trailing.centerY.equalToSuperview()
        }
        featureSwitch.onTintColor = DS.Colors.indicatorStatusPositive
        featureSwitch.transform = CGAffineTransform(scaleX: Layout.switchScale, y: Layout.switchScale)
        featureSwitch.addTarget(self, action: #selector(toggleSwitchChanged), for: .valueChanged)
    }

    func setupSubtitleLabel() {
        cardView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom).offset(DS.Spacing.x16)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
        }
        subtitleLabel.textColor = DS.Colors.textTertiary
        subtitleLabel.font = DS.Font.regular(12)
        subtitleLabel.numberOfLines = 0
    }

    func setupExtraTimeRowView() {
        cardView.addSubview(extraTimeRowView)
        extraTimeRowView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(DS.Spacing.x20)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
            $0.bottom.equalToSuperview().inset(DS.Spacing.x20)
        }
    }

    @objc
    func toggleSwitchChanged() {
        onToggleChanged?(featureSwitch.isOn)
    }

    func showExtraTimePopover() {
        guard !minuteOptions.isEmpty else { return }
        guard let hostViewController else { return }

        let controller = MinutesPopoverViewController(
            options: minuteOptions,
            selectedValue: selectedMinute
        ) { [weak self] value in
            self?.onExtraTimeSelected?(value)
        }
        controller.modalPresentationStyle = .popover

        guard let popover = controller.popoverPresentationController else {
            hostViewController.present(controller, animated: true)
            return
        }

        popover.sourceView = extraTimeRowView
        popover.sourceRect = extraTimeRowView.bounds
        popover.permittedArrowDirections = [.up, .down]
        popover.delegate = controller

        hostViewController.present(controller, animated: true)
    }

    var hostViewController: UIViewController? {
        sequence(first: self as UIResponder?, next: { $0?.next })
            .first { $0 is UIViewController } as? UIViewController
    }
}

