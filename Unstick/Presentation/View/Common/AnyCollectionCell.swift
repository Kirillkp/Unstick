//
//  AnyCollectionCell.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import UIKit
import SnapKit

final class AnyCollectionCell<ContentView: UIView & ConfigurableView>: UICollectionViewCell {
    let hostedView = ContentView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }

    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let targetSize = CGSize(
            width: layoutAttributes.size.width,
            height: UIView.layoutFittingCompressedSize.height
        )
        let fittedSize = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        let attributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        attributes.size.height = ceil(fittedSize.height)
        return attributes
    }
}

extension AnyCollectionCell: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        hostedView.configure(with: model)
    }
}

private extension AnyCollectionCell {
    func createUI() {
        setupHostedView()
    }

    func setupHostedView() {
        contentView.addSubview(hostedView)
        hostedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
