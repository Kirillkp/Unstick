//
//  StatisticsWeeklyActivityCardView.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit
import SnapKit

final class StatisticsWeeklyActivityCardView: UIView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let selectedValueLabel = UILabel()
    private let chartView = StatisticsWeeklyActivityChartView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension StatisticsWeeklyActivityCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? StatisticsWeeklyActivityModel else { return }

        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        selectedValueLabel.text = model.items.first.map { "\($0.dayTitle) · \($0.valueTitle)" }
        chartView.onSelectionChanged = { [weak self] item in
            self?.selectedValueLabel.text = "\(item.dayTitle) · \(item.valueTitle)"
        }
        chartView.configure(items: model.items)
    }
}

private extension StatisticsWeeklyActivityCardView {
    func createUI() {
        setupSelf()
        setupTitleLabel()
        setupSubtitleLabel()
        setupSelectedValueLabel()
        setupChartView()
    }

    func setupSelf() {
        backgroundColor = DS.Colors.surfacePrimary.withAlphaComponent(0.72)
        layer.cornerRadius = DS.CornerRadius.x32
        layer.borderWidth = 1
        layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.24).cgColor
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(DS.Spacing.x16)
        }
        titleLabel.textColor = DS.Colors.textSecondary
        titleLabel.font = DS.Font.semiBold(18)
        titleLabel.numberOfLines = 1
    }

    func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(DS.Spacing.x4)
            $0.leading.equalToSuperview().inset(DS.Spacing.x16)
            $0.trailing.lessThanOrEqualToSuperview().inset(DS.Spacing.x16)
        }
        subtitleLabel.textColor = DS.Colors.textTertiary
        subtitleLabel.font = DS.Font.regular(12)
        subtitleLabel.numberOfLines = 1
    }

    func setupSelectedValueLabel() {
        addSubview(selectedValueLabel)
        selectedValueLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(DS.Spacing.x12)
            $0.leading.equalToSuperview().inset(DS.Spacing.x16)
            $0.trailing.lessThanOrEqualToSuperview().inset(DS.Spacing.x16)
        }
        selectedValueLabel.textColor = DS.Colors.textSecondary
        selectedValueLabel.font = DS.Font.semiBold(13)
        selectedValueLabel.numberOfLines = 1
    }

    func setupChartView() {
        addSubview(chartView)
        chartView.snp.makeConstraints {
            $0.top.equalTo(selectedValueLabel.snp.bottom).offset(DS.Spacing.x12)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x12)
            $0.bottom.equalToSuperview().inset(DS.Spacing.x16)
        }
    }
}

private final class StatisticsWeeklyActivityChartView: UIView {
    private enum Layout {
        static let chartHeight: CGFloat = 116
        static let barWidth: CGFloat = 16
        static let minimumBarHeight: CGFloat = 16
        static let barCornerRadius: CGFloat = 8
    }

    var onSelectionChanged: ((StatisticsWeeklyActivityModel.DayActivity) -> Void)?

    private let guidesView = UIView()
    private let daysStackView = UIStackView()
    private var dayViews: [DayColumnView] = []
    private var items: [StatisticsWeeklyActivityModel.DayActivity] = []
    private var selectedIndex: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }

    @MainActor
    func configure(items: [StatisticsWeeklyActivityModel.DayActivity]) {
        self.items = items
        selectedIndex = min(selectedIndex, max(items.count - 1, 0))
        rebuildDayViews(with: items)
        updateSelection(animated: false)
    }
}

private extension StatisticsWeeklyActivityChartView {
    func createUI() {
        setupGuidesView()
        setupDaysStackView()
    }

    func setupGuidesView() {
        addSubview(guidesView)
        guidesView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Layout.chartHeight)
        }

        let topGuide = makeGuideLineView()
        let middleGuide = makeGuideLineView()

        guidesView.addSubview(topGuide)
        guidesView.addSubview(middleGuide)

        topGuide.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }

        middleGuide.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func setupDaysStackView() {
        addSubview(daysStackView)
        daysStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        daysStackView.axis = .horizontal
        daysStackView.alignment = .bottom
        daysStackView.distribution = .fillEqually
        daysStackView.spacing = DS.Spacing.x4
    }

    @MainActor
    func rebuildDayViews(with items: [StatisticsWeeklyActivityModel.DayActivity]) {
        dayViews.forEach {
            daysStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        dayViews = items.enumerated().map { index, item in
            let view = DayColumnView(item: item)
            view.onTap = { [weak self] in
                self?.handleTap(on: index)
            }
            return view
        }
        dayViews.forEach(daysStackView.addArrangedSubview)
    }

    func handleTap(on index: Int) {
        guard items.indices.contains(index) else { return }
        selectedIndex = index
        updateSelection(animated: true)
    }

    func updateSelection(animated: Bool) {
        for (index, dayView) in dayViews.enumerated() {
            dayView.setSelected(index == selectedIndex, animated: animated)
        }

        guard items.indices.contains(selectedIndex) else { return }
        onSelectionChanged?(items[selectedIndex])
    }

    func makeGuideLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = DS.Colors.borderPrimary.withAlphaComponent(0.18)
        return view
    }
}

private final class DayColumnView: UIView {
    private enum Layout {
        static let chartHeight: CGFloat = 116
        static let barWidth: CGFloat = 18
        static let minimumBarHeight: CGFloat = 16
        static let barCornerRadius: CGFloat = 9
    }

    private let barAreaView = UIView()
    private let barView = UIView()
    private let dayLabel = UILabel()
    private let tapButton = UIButton(type: .custom)

    private var barHeightConstraint: Constraint?
    private let item: StatisticsWeeklyActivityModel.DayActivity
    var onTap: (() -> Void)?

    init(item: StatisticsWeeklyActivityModel.DayActivity) {
        self.item = item
        super.init(frame: .zero)
        createUI()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DayColumnView {
    func createUI() {
        setupBarAreaView()
        setupBarView()
        setupDayLabel()
        setupTapButton()
    }

    func setupBarAreaView() {
        addSubview(barAreaView)
        barAreaView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Layout.chartHeight)
        }
    }

    func setupBarView() {
        barAreaView.addSubview(barView)
        barView.snp.makeConstraints {
            $0.centerX.bottom.equalToSuperview()
            $0.width.equalTo(Layout.barWidth)
            barHeightConstraint = $0.height.equalTo(Layout.minimumBarHeight).constraint
        }
        barView.layer.cornerRadius = Layout.barCornerRadius
    }

    func setupDayLabel() {
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.top.equalTo(barAreaView.snp.bottom).offset(DS.Spacing.x8)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        dayLabel.textColor = DS.Colors.textTertiary
        dayLabel.font = DS.Font.medium(10)
        dayLabel.textAlignment = .center
        dayLabel.numberOfLines = 1
    }

    func setupTapButton() {
        addSubview(tapButton)
        tapButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tapButton.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    func configure() {
        dayLabel.text = item.dayTitle
        barView.backgroundColor = color(for: item.style)

        let normalizedValue = max(0.18, min(item.value, 1))
        let height = Layout.chartHeight * normalizedValue
        barHeightConstraint?.update(offset: height)
    }

    func setSelected(_ isSelected: Bool, animated: Bool) {
        let updates = {
            self.barView.alpha = isSelected ? 1 : 0.72
            self.dayLabel.textColor = isSelected ? DS.Colors.textSecondary : DS.Colors.textTertiary
            self.transform = isSelected ? CGAffineTransform(scaleX: 1.04, y: 1.0) : .identity
        }

        if animated {
            UIView.animate(withDuration: 0.2, animations: updates)
        } else {
            updates()
        }
    }

    func color(for style: StatisticsWeeklyActivityModel.DayActivity.Style) -> UIColor {
        switch style {
        case .primary:
            return DS.Colors.tertiary
        case .accent:
            return DS.Colors.primary
        case .warning:
            return UIColor.hex("#EC6A87")
        }
    }

    @objc
    func handleTap() {
        onTap?()
    }
}
