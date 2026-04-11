//
//  RestrictionSetupGroupNameCardView.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit
import SnapKit

final class RestrictionSetupGroupNameCardView: UIView {
    private enum Layout {
        static let cardInset: CGFloat = DS.Spacing.x20
        static let iconContainerSize = CGSize(width: 40, height: 40)
        static let iconSize = CGSize(width: 18, height: 18)
        static let valueContainerHeight: CGFloat = 72
    }

    private let cardView = UIView()
    private let headerContainerView = UIView()
    private let iconContainerView = UIView()
    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let valueContainerView = UIView()
    private let valueTextField = UITextField()
    private var onValueChanged: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createUI()
    }
}

extension RestrictionSetupGroupNameCardView: ConfigurableView {
    func configure(with model: any BaseCellViewModel) {
        guard let model = model as? RestrictionSetupGroupNameCardModel else { return }

        titleLabel.text = model.title
        if valueTextField.text != model.value {
            valueTextField.text = model.value
        }
        valueTextField.attributedPlaceholder = NSAttributedString(
            string: model.placeholder,
            attributes: [
                .foregroundColor: DS.Colors.textTertiary,
                .font: DS.Font.medium(18)
            ]
        )
        onValueChanged = model.onValueChanged
    }
}

private extension RestrictionSetupGroupNameCardView {
    func createUI() {
        setupSelf()
        setupCardView()
        setupHeaderContainerView()
        setupIconContainerView()
        setupIconView()
        setupTitleLabel()
        setupValueContainerView()
        setupValueTextField()
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
        iconView.image = UIImage(systemName: "textformat")
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

    func setupValueContainerView() {
        cardView.addSubview(valueContainerView)
        valueContainerView.snp.makeConstraints {
            $0.top.equalTo(headerContainerView.snp.bottom).offset(DS.Spacing.x16)
            $0.horizontalEdges.bottom.equalToSuperview().inset(Layout.cardInset)
            $0.height.equalTo(Layout.valueContainerHeight)
        }
        valueContainerView.backgroundColor = DS.Colors.neutral
        valueContainerView.layer.cornerRadius = Layout.valueContainerHeight / 2
    }

    func setupValueTextField() {
        valueContainerView.addSubview(valueTextField)
        valueTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(DS.Spacing.x24)
            $0.centerY.equalToSuperview()
        }
        valueTextField.textColor = DS.Colors.textSecondary
        valueTextField.font = DS.Font.medium(18)
        valueTextField.tintColor = DS.Colors.primary
        valueTextField.autocapitalizationType = .sentences
        valueTextField.clearButtonMode = .whileEditing
        valueTextField.returnKeyType = .done
        valueTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        valueTextField.delegate = self
    }

    @objc
    func textFieldChanged() {
        onValueChanged?(valueTextField.text ?? "")
    }
}

extension RestrictionSetupGroupNameCardView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
