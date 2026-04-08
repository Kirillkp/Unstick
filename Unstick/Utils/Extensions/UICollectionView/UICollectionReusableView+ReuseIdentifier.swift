//
//  UICollectionReusableView+ReuseIdentifier.swift
//  Unstick
//
//  Created by Codex on 05.04.2026.
//

import UIKit

protocol ReusableView: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}

extension UICollectionViewCell: ReusableView {}
extension UICollectionReusableView: ReusableView {}
