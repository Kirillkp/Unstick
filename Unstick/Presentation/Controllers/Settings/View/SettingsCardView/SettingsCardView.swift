//
//  SettingsCardView.swift
//  Unstick
//
//  Created by Codex on 09.04.2026.
//

import UIKit
import SnapKit

final class SettingsCardView: UIView {
    private enum Layout {
        static let rowHeight: CGFloat = 54
        static let contentInset = UIEdgeInsets(vertical: DS.Spacing.x6)
    }

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension SettingsCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? SettingsCardModel else { return }

        stackView.arrangedSubviews.forEach { subview in
            stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        for (index, row) in model.rows.enumerated() {
            let rowView = SettingsRowView()
            rowView.configure(
                with: row,
                showsSeparator: index < model.rows.count - 1
            )
            rowView.snp.makeConstraints {
                $0.height.equalTo(Layout.rowHeight)
            }
            stackView.addArrangedSubview(rowView)
        }
    }
}

private extension SettingsCardView {
    func createUI() {
        setupSelf()
        setupStackView()
    }

    func setupSelf() {
        backgroundColor = DS.Colors.surfacePrimary.withAlphaComponent(0.72)
        layer.cornerRadius = DS.CornerRadius.x32
        layer.borderWidth = 1
        layer.borderColor = DS.Colors.borderPrimary.withAlphaComponent(0.18).cgColor
    }

    func setupStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(Layout.contentInset)
        }
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
    }
}
