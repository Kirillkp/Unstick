//
//  GroupDetailsViewController.swift
//  Unstick
//
//  Created by Codex on 14.04.2026.
//

import UIKit
import SnapKit

final class GroupDetailsViewController: UIViewController {
    private enum Layout {
        static let bottomInset: CGFloat = DS.Spacing.x16
    }

    var presenter: GroupDetailsPresenterProtocol?

    private let collectionView = ContentSizedCollectionView(
        frame: .zero,
        collectionViewLayout: GroupDetailsCollectionLayoutBuilder.makeLayout()
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        presenter?.viewLoaded()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
        presenter?.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter?.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter?.viewWillDisappear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateBottomInsets()
    }
}

extension GroupDetailsViewController: GroupDetailsViewProtocol {
    var _collectionView: UICollectionView {
        collectionView
    }

    func refreshCollectionLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        view.layoutIfNeeded()
    }
}

private extension GroupDetailsViewController {
    func createUI() {
        setupSelf()
        setupCollectionView()
    }

    func setupSelf() {
        view.backgroundColor = DS.Colors.neutral
        title = ""
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

    func updateBottomInsets() {
        let inset = Layout.bottomInset + view.safeAreaInsets.bottom
        collectionView.contentInset.bottom = inset
        collectionView.verticalScrollIndicatorInsets.bottom = inset
    }
}

private extension GroupDetailsViewController {
    var collectionBottomAnchorItem: ConstraintRelatableTarget {
        if #available(iOS 18.0, *) {
            view.snp.bottom
        } else {
            view.safeAreaLayoutGuide.snp.bottom
        }
    }
}

