//
//  ContentSizedCollectionView.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit

final class ContentSizedCollectionView: UICollectionView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()

        return CGSize(
            width: UIView.noIntrinsicMetric,
            height: collectionViewLayout.collectionViewContentSize.height
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        invalidateIntrinsicContentSize()
    }
}
