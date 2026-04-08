//
//  CollectionButtonRowView.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit
import SnapKit

final class CollectionButtonRowView: UIView {

    private let button = DSButton()
    private var onTap: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension CollectionButtonRowView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? CollectionButtonRowModel else { return }

        button.setStyle(model.buttonStyle, size: model.buttonSize)
        button.setTitle(model.title, for: .normal)
        button.setImage(model.image, for: .normal)
        onTap = model.onTap
    }
}

private extension CollectionButtonRowView {
    func createUI() {
        setupButton()
    }

    func setupButton() {
        addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        button.addTarget(
            self,
            action: #selector(buttonTapped),
            for: .touchUpInside
        )
    }

    @objc
    func buttonTapped() {
        onTap?()
    }
}
