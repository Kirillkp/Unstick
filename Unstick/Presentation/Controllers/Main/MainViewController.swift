//
//  MainViewController.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private enum Layout {
        static let indicatorSize = CGSize(width: 256, height: 256)
    }

    var presenter: MainPresenterProtocol?

    private let backgroundView = MeshGradientView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let indicatorView = IndicatorView()
    private let emptyStateView = MainEmptyStateView()
    private let collectionView = ContentSizedCollectionView(
        frame: .zero,
        collectionViewLayout: MainCollectionLayoutBuilder.makeLayout()
    )

    private var scrollViewBottomConstraint: Constraint?
    private var collectionHeightConstraint: Constraint?
    private var contentBottomToEmptyStateConstraint: Constraint?
    private var contentBottomToCollectionConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        createUI()
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        updateBottomInsets()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter?.viewWillDisappear(animated)
    }

}

extension MainViewController: MainViewProtocol {
    var _collectionView: UICollectionView {
        collectionView
    }

    func display(state: MainViewState) {
        switch state {
        case .empty(let model):
            displayEmptyState(model)
        case .filled(let model):
            displayFilledState(model)
        }
    }

    func setCollectionHidden(_ isHidden: Bool) {
        collectionView.isHidden = isHidden
    }

    func refreshCollectionLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.invalidateIntrinsicContentSize()
        collectionView.layoutIfNeeded()
        collectionHeightConstraint?.update(offset: collectionView.collectionViewLayout.collectionViewContentSize.height)
        contentView.layoutIfNeeded()
        scrollView.layoutIfNeeded()
        view.layoutIfNeeded()
    }
}

private extension MainViewController {
    func createUI() {
        setupBackgroundView()
        setupScrollView()
        setupContentView()
        setupIndicatorView()
        setupEmptyStateView()
        setupCollectionView()
    }

    func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            scrollViewBottomConstraint = $0.bottom.equalTo(scrollViewBottomAnchorItem).constraint
        }
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
    }

    func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
    }

    func setupIndicatorView() {
        contentView.addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(DS.Spacing.x48)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(Layout.indicatorSize)
        }
    }

    func setupEmptyStateView() {
        contentView.addSubview(emptyStateView)
        emptyStateView.snp.makeConstraints {
            $0.top.equalTo(indicatorView.snp.bottom).offset(DS.Spacing.x14)
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x24)
        }
        contentView.snp.makeConstraints {
            contentBottomToEmptyStateConstraint = $0.bottom.equalTo(emptyStateView.snp.bottom).offset(contentBottomInset).constraint
        }
        emptyStateView.isHidden = true
    }

    func setupCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(indicatorView.snp.bottom).offset(DS.Spacing.x24)
            $0.horizontalEdges.equalToSuperview()
            collectionHeightConstraint = $0.height.equalTo(1).constraint
        }
        contentView.snp.makeConstraints {
            contentBottomToCollectionConstraint = $0.bottom.equalTo(collectionView.snp.bottom).offset(contentBottomInset).constraint
        }
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.setContentHuggingPriority(.required, for: .vertical)
        collectionView.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    func bindActions() {
        emptyStateView.onDidTapActionButton = { [weak self] in
            self?.presenter?.nextAction()
        }
    }

    func updateBottomInsets() {
        let bottomInset = contentBottomInset

        contentBottomToEmptyStateConstraint?.update(offset: bottomInset)
        contentBottomToCollectionConstraint?.update(offset: bottomInset)
        scrollView.verticalScrollIndicatorInsets.bottom = view.safeAreaInsets.bottom
    }

    func displayEmptyState(_ model: MainEmptyStateModel) {
        indicatorView.setState(.empty(.init()))
        emptyStateView.configure(model)

        emptyStateView.isHidden = false
        setCollectionHidden(true)
        contentBottomToEmptyStateConstraint?.activate()
        contentBottomToCollectionConstraint?.deactivate()
    }

    func displayFilledState(_ model: MainViewState.Filled) {
        indicatorView.setState(model.indicatorState)

        emptyStateView.isHidden = true
        setCollectionHidden(false)
        contentBottomToEmptyStateConstraint?.deactivate()
        contentBottomToCollectionConstraint?.activate()
    }
}

private extension MainViewController {
    var contentBottomInset: CGFloat {
        DS.Spacing.x16 + view.safeAreaInsets.bottom
    }

    var scrollViewBottomAnchorItem: ConstraintRelatableTarget {
        if #available(iOS 18.0, *) {
            view.snp.bottom
        } else {
            view.safeAreaLayoutGuide.snp.bottom
        }
    }
}
