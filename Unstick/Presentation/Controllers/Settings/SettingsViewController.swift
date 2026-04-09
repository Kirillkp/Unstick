//
//  SettingsViewController.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 27.03.2026
//
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    private enum Layout {
        static let titleTopInset: CGFloat = 8
    }

    var presenter: SettingsPresenterProtocol?

    private let titleLabel = UILabel()
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: SettingsCollectionLayoutBuilder.makeLayout()
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: true)
        createUI()
        presenter?.viewLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter?.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateCollectionInsets()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter?.viewWillDisappear(animated)
    }
}

extension SettingsViewController: SettingsViewProtocol {
    var _collectionView: UICollectionView {
        collectionView
    }

    func display(state: SettingsViewState) {}

    func refreshCollectionLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }
}

private extension SettingsViewController {
    func createUI() {
        setupSelf()
        setupTitleLabel()
        setupCollectionView()
    }

    func setupSelf() {
        view.backgroundColor = DS.Colors.neutral
    }

    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Layout.titleTopInset)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x24)
        }
        titleLabel.text = L10n.Settings.title
        titleLabel.textColor = DS.Colors.textPrimary
        titleLabel.font = DS.Font.bold(34)
        titleLabel.numberOfLines = 1
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(DS.Spacing.x20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(collectionBottomAnchorItem)
        }
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
    }

    func updateCollectionInsets() {
        let bottomInset = collectionBottomInset
        collectionView.contentInset.bottom = bottomInset
        collectionView.verticalScrollIndicatorInsets.bottom = bottomInset
    }
}

private extension SettingsViewController {
    var collectionBottomInset: CGFloat {
        let tabBarHeight = tabBarController?.tabBar.frame.height ?? 0
        return tabBarHeight + DS.Spacing.x16
    }

    var collectionBottomAnchorItem: ConstraintRelatableTarget {
        if #available(iOS 18.0, *) {
            view.snp.bottom
        } else {
            view.safeAreaLayoutGuide.snp.bottom
        }
    }
}
