//
//  BreakCardView.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit
import SnapKit

final class BreakCardView: UIView {
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
    private let remindRowView = RestrictionSetupTimeSelectionRowView()
    private let durationRowView = RestrictionSetupTimeSelectionRowView()

    private var minuteOptions: [Int] = []
    private var selectedRemindMinute = 0
    private var selectedDurationMinute = 0
    private var onEnabledChanged: ((Bool) -> Void)?
    private var onRemindEverySelected: ((Int) -> Void)?
    private var onDurationSelected: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension BreakCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? BreakCardModel else { return }

        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        featureSwitch.isOn = model.isEnabled
        minuteOptions = model.minuteOptions
        selectedRemindMinute = model.remindEverySelectedMinute
        selectedDurationMinute = model.durationSelectedMinute
        onEnabledChanged = model.onEnabledChanged
        onRemindEverySelected = model.onRemindEverySelected
        onDurationSelected = model.onDurationSelected

        subtitleLabel.alpha = model.isEnabled ? 1 : 0.52

        remindRowView.configure(
            title: model.remindEveryTitle,
            value: model.remindEveryValue,
            isEnabled: model.isEnabled
        ) { [weak self] in
            self?.showRemindPopover()
        }

        durationRowView.configure(
            title: model.durationTitle,
            value: model.durationValue,
            isEnabled: model.isEnabled
        ) { [weak self] in
            self?.showDurationPopover()
        }
    }
}

private extension BreakCardView {
    func createUI() {
        setupSelf()
        setupCardView()
        setupHeaderContainerView()
        setupIconContainerView()
        setupIconView()
        setupTitleLabel()
        setupFeatureSwitch()
        setupSubtitleLabel()
        setupRemindRowView()
        setupDurationRowView()
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
        iconContainerView.backgroundColor = DS.Colors.surfaceElevated.withAlphaComponent(0.72)
        iconContainerView.layer.cornerRadius = Layout.iconContainerSize.width / 2
    }

    func setupIconView() {
        iconContainerView.addSubview(iconView)
        iconView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.iconSize)
        }
        iconView.image = UIImage(systemName: "timer")
        iconView.tintColor = DS.Colors.textSecondary
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
        featureSwitch.addTarget(self, action: #selector(featureSwitchChanged), for: .valueChanged)
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

    func setupRemindRowView() {
        cardView.addSubview(remindRowView)
        remindRowView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(DS.Spacing.x20)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
        }
    }

    func setupDurationRowView() {
        cardView.addSubview(durationRowView)
        durationRowView.snp.makeConstraints {
            $0.top.equalTo(remindRowView.snp.bottom).offset(DS.Spacing.x12)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x20)
            $0.bottom.equalToSuperview().inset(DS.Spacing.x20)
        }
    }

    @objc
    func featureSwitchChanged() {
        onEnabledChanged?(featureSwitch.isOn)
    }

    func showRemindPopover() {
        presentMinutePopover(
            from: remindRowView,
            selectedMinute: selectedRemindMinute
        ) { [weak self] minute in
            self?.onRemindEverySelected?(minute)
        }
    }

    func showDurationPopover() {
        presentMinutePopover(
            from: durationRowView,
            selectedMinute: selectedDurationMinute
        ) { [weak self] minute in
            self?.onDurationSelected?(minute)
        }
    }

    func presentMinutePopover(
        from sourceView: UIView,
        selectedMinute: Int,
        onSelected: @escaping (Int) -> Void
    ) {
        guard !minuteOptions.isEmpty else { return }
        guard let hostViewController else { return }

        let controller = MinutesPopoverViewController(
            options: minuteOptions,
            selectedValue: selectedMinute
        ) { value in
            onSelected(value)
        }
        controller.modalPresentationStyle = .popover

        guard let popover = controller.popoverPresentationController else {
            hostViewController.present(controller, animated: true)
            return
        }

        popover.sourceView = sourceView
        popover.sourceRect = sourceView.bounds
        popover.permittedArrowDirections = [.up, .down]
        popover.delegate = controller

        hostViewController.present(controller, animated: true)
    }

    var hostViewController: UIViewController? {
        sequence(first: self as UIResponder?, next: { $0?.next })
            .first { $0 is UIViewController } as? UIViewController
    }
}

