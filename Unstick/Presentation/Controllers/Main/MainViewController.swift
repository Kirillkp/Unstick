//
//  MainViewController.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol?

    private let collectionView = ContentSizedCollectionView(
        frame: .zero,
        collectionViewLayout: MainCollectionLayoutBuilder.makeLayout()
    )

    private var sceneDidBecomeActiveObserver: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        createUI()
        observeLifecycle()
        bindActions()
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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter?.viewWillDisappear(animated)
    }

    deinit {
        removeLifecycleObserver()
    }

}

extension MainViewController: MainViewProtocol {
    var _collectionView: UICollectionView {
        collectionView
    }

    func setCollectionHidden(_ isHidden: Bool) {
        collectionView.isHidden = isHidden
    }

    func refreshCollectionLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
    }
}

private extension MainViewController {
    func createUI() {
        setupBackgroundView()
        setupCollectionView()
    }

    func setupBackgroundView() {
        view.backgroundColor = DS.Colors.neutral
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: DS.Spacing.x16,
            right: 0
        )
        collectionView.verticalScrollIndicatorInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: view.safeAreaInsets.bottom,
            right: 0
        )
    }

    func bindActions() {}

    func observeLifecycle() {
        sceneDidBecomeActiveObserver = NotificationCenter.default.addObserver(
            forName: .sceneDidBecomeActive,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            self?.presenter?.sceneDidBecomeActive()
        }
    }

    func removeLifecycleObserver() {
        guard let sceneDidBecomeActiveObserver else { return }
        NotificationCenter.default.removeObserver(sceneDidBecomeActiveObserver)
        self.sceneDidBecomeActiveObserver = nil
    }
}
