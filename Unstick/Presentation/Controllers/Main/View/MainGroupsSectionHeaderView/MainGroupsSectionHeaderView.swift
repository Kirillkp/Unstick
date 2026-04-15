//
//  MainGroupsSectionHeaderView.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import UIKit
import SnapKit

final class MainGroupsSectionHeaderView: UICollectionReusableView {

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

extension MainGroupsSectionHeaderView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? MainGroupsSectionHeaderModel else { return }
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
}

private extension MainGroupsSectionHeaderView {
    func createUI() {
        setupTitleLabel()
        setupSubtitleLabel()
    }

    func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        titleLabel.textColor = DS.Colors.textPrimary
        titleLabel.font = DS.Font.bold(24)
    }

    func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(titleLabel)
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(DS.Spacing.x16)
        }
        subtitleLabel.textColor = DS.Colors.textTertiary
        subtitleLabel.font = DS.Font.regular(14)
        subtitleLabel.textAlignment = .right
    }
}
