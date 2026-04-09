//
//  StatisticsViewController.swift
//  Unstick
//
//  Created by Codex on 08.04.2026.
//

import UIKit
import SnapKit

final class StatisticsViewController: UIViewController {
    var presenter: StatisticsPresenterProtocol?

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: StatisticsCollectionLayoutBuilder.makeLayout()
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

extension StatisticsViewController: StatisticsViewProtocol {
    var _collectionView: UICollectionView {
        collectionView
    }

    func display(state: StatisticsViewState) {}

    func refreshCollectionLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }
}

private extension StatisticsViewController {
    func createUI() {
        setupSelf()
        setupCollectionView()
    }

    func setupSelf() {
        view.backgroundColor = DS.Colors.neutral
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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

private extension StatisticsViewController {
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
