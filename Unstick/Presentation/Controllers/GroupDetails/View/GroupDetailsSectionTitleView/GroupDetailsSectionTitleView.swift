//
//  GroupDetailsSectionTitleView.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit
import SnapKit

final class GroupDetailsSectionTitleView: UIView {
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension GroupDetailsSectionTitleView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? GroupDetailsSectionTitleModel else { return }
        titleLabel.text = model.title.uppercased()
    }
}

private extension GroupDetailsSectionTitleView {
    func createUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(DS.Spacing.x8)
        }
        titleLabel.textColor = DS.Colors.textTertiary.withAlphaComponent(0.8)
        titleLabel.font = DS.Font.medium(11)
        titleLabel.numberOfLines = 1
    }
}

