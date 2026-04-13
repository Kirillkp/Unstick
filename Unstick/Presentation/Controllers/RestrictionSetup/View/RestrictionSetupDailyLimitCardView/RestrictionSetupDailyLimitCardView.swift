//
//  RestrictionSetupDailyLimitCardView.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit
import SnapKit

final class RestrictionSetupDailyLimitCardView: UIView {
    private enum Layout {
        static let cardInset: CGFloat = DS.Spacing.x20
        static let iconContainerSize = CGSize(width: 40, height: 40)
        static let iconSize = CGSize(width: 18, height: 18)
        static let pickerHeight: CGFloat = 180
    }

    private let cardView = UIView()
    private let headerContainerView = UIView()
    private let iconContainerView = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let pickerView = UIPickerView()
    private let captionLabel = UILabel()

    private var hours: [Int] = []
    private var minutes: [Int] = []
    private var onHourChanged: ((Int) -> Void)?
    private var onMinuteChanged: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension RestrictionSetupDailyLimitCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? RestrictionSetupDailyLimitCardModel else { return }

        titleLabel.text = model.title
        captionLabel.text = model.caption
        hours = model.hours
        minutes = model.minutes
        onHourChanged = model.onHourChanged
        onMinuteChanged = model.onMinuteChanged

        pickerView.reloadAllComponents()

        if let hourIndex = hours.firstIndex(of: model.selectedHour) {
            pickerView.selectRow(hourIndex, inComponent: 0, animated: false)
        }
        if let minuteIndex = minutes.firstIndex(of: model.selectedMinute) {
            pickerView.selectRow(minuteIndex, inComponent: 1, animated: false)
        }
    }
}

private extension RestrictionSetupDailyLimitCardView {
    func createUI() {
        setupSelf()
        setupCardView()
        setupHeaderContainerView()
        setupIconContainerView()
        setupIconView()
        setupTitleLabel()
        setupPickerView()
        setupCaptionLabel()
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

    func setupHeaderContainerView() {
        cardView.addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(Layout.cardInset)
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
        iconView.image = UIImage(systemName: "clock")
        iconView.tintColor = DS.Colors.textSecondary
        iconView.contentMode = .scaleAspectFit
    }

    func setupTitleLabel() {
        headerContainerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconContainerView.snp.trailing).offset(DS.Spacing.x12)
            $0.trailing.centerY.equalToSuperview()
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.bold(17)
        titleLabel.numberOfLines = 1
    }

    func setupPickerView() {
        cardView.addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom).offset(DS.Spacing.x16)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x24)
            $0.height.equalTo(Layout.pickerHeight)
        }
        pickerView.backgroundColor = .clear
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    func setupCaptionLabel() {
        cardView.addSubview(captionLabel)
        captionLabel.snp.makeConstraints {
            $0.top.equalTo(pickerView.snp.bottom).offset(DS.Spacing.x16)
            $0.horizontalEdges.bottom.equalToSuperview().inset(Layout.cardInset)
        }
        captionLabel.textColor = UIColor.hex("E4DFFF")
        captionLabel.font = DS.Font.bold(10)
        captionLabel.textAlignment = .center
        captionLabel.numberOfLines = 1
    }
}

extension RestrictionSetupDailyLimitCardView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? hours.count : minutes.count
    }

    private func title(
        for row: Int,
        component: Int
    ) -> String {
        if component == 0 {
            return L10n.RestrictionSetup.DailyLimit.hourValueFormat(arg0: hours[row])
        }

        return L10n.RestrictionSetup.DailyLimit.minuteValueFormat(arg0: minutes[row])
    }

    func pickerView(
        _ pickerView: UIPickerView,
        attributedTitleForRow row: Int,
        forComponent component: Int
    ) -> NSAttributedString? {
        NSAttributedString(
            string: title(for: row, component: component),
            attributes: [
                .foregroundColor: UIColor.hex("E4DFFF"),
                .font: DS.Font.medium(34)
            ]
        )
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        pickerView.bounds.width / 2
    }

    func pickerView(
        _ pickerView: UIPickerView,
        rowHeightForComponent component: Int
    ) -> CGFloat {
        44
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        if component == 0 {
            onHourChanged?(hours[row])
            return
        }

        onMinuteChanged?(minutes[row])
    }
}
