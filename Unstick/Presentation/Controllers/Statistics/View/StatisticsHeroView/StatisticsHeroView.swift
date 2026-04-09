//
//  StatisticsHeroView.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit
import SnapKit

final class StatisticsHeroView: UIView {
    private enum Layout {
        static let titleLineHeight: CGFloat = 48
        static let subtitleLineHeight: CGFloat = 18
    }

    private let contentStackView = UIStackView()
    private let badgeLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension StatisticsHeroView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? StatisticsHeroModel else { return }

        badgeLabel.text = model.badge
        badgeLabel.applyFontStyle(.caption2)

        titleLabel.attributedText = makeTitleText(
            title: model.title,
            highlightedHours: model.highlightedHours,
            highlightedMinutes: model.highlightedMinutes
        )

        subtitleLabel.attributedText = makeSubtitleText(model.subtitle)
    }
}

private extension StatisticsHeroView {
    func createUI() {
        setupContentStackView()
        setupBadgeLabel()
        setupTitleLabel()
        setupSubtitleLabel()
    }

    func setupContentStackView() {
        addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.spacing = DS.Spacing.x12
    }

    func setupBadgeLabel() {
        contentStackView.addArrangedSubview(badgeLabel)
        badgeLabel.textColor = DS.Colors.textTertiary
        badgeLabel.numberOfLines = 1
    }

    func setupTitleLabel() {
        contentStackView.addArrangedSubview(titleLabel)
        titleLabel.numberOfLines = 0
    }

    func setupSubtitleLabel() {
        contentStackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.textColor = DS.Colors.textTertiary
        subtitleLabel.numberOfLines = 0
    }

    func makeTitleText(
        title: String,
        highlightedHours: String,
        highlightedMinutes: String
    ) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = Layout.titleLineHeight
        paragraphStyle.maximumLineHeight = Layout.titleLineHeight
        paragraphStyle.lineBreakMode = .byWordWrapping

        let result = NSMutableAttributedString(
            string: title,
            attributes: [
                .font: DS.Font.extraBold(44),
                .foregroundColor: DS.Colors.textSecondary,
                .paragraphStyle: paragraphStyle
            ]
        )

        let fullText = result.string as NSString
        let highlightedParts = [highlightedHours, highlightedMinutes]

        highlightedParts.forEach { highlightedText in
            let range = fullText.range(of: highlightedText)
            guard range.location != NSNotFound else { return }

            result.addAttributes(
                [
                    .font: DS.Font.extraBold(44),
                    .foregroundColor: DS.Colors.primary,
                    .paragraphStyle: paragraphStyle
                ],
                range: range
            )
        }

        return result
    }

    func makeSubtitleText(_ text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = Layout.subtitleLineHeight
        paragraphStyle.maximumLineHeight = Layout.subtitleLineHeight
        paragraphStyle.lineBreakMode = .byWordWrapping

        return NSAttributedString(
            string: text,
            attributes: [
                .font: DS.Font.regular(12),
                .foregroundColor: DS.Colors.textTertiary,
                .paragraphStyle: paragraphStyle
            ]
        )
    }
}
