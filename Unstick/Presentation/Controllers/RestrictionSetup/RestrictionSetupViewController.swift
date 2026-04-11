//
//  RestrictionSetupViewController.swift
//  Unstick
//
//  Created by Codex on 11.04.2026.
//

import UIKit
import SnapKit

final class RestrictionSetupViewController: UIViewController {
    private enum Layout {
        static let buttonHorizontalInset: CGFloat = DS.Spacing.x24
        static let buttonTopInset: CGFloat = DS.Spacing.x16
        static let buttonBottomInset: CGFloat = DS.Spacing.x16
    }

    var presenter: RestrictionSetupPresenterProtocol?

    private let collectionView = ContentSizedCollectionView(
        frame: .zero,
        collectionViewLayout: RestrictionSetupCollectionLayoutBuilder.makeLayout()
    )
    private let continueButton = DSButton()

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

extension RestrictionSetupViewController: RestrictionSetupViewProtocol {
    var _collectionView: UICollectionView {
        collectionView
    }

    func display(state: RestrictionSetupViewState) {
        switch state {
        case let .filled(_, _, _, _, _, continueTitle, isContinueEnabled):
            continueButton.setTitle(continueTitle, for: .normal)
            continueButton.isEnabled = isContinueEnabled
            continueButton.alpha = isContinueEnabled ? 1 : 0.72
        }
    }

    func refreshCollectionLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        view.layoutIfNeeded()
    }
}

private extension RestrictionSetupViewController {
    func createUI() {
        setupSelf()
        setupCollectionView()
        setupContinueButton()
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

    func setupContinueButton() {
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Layout.buttonHorizontalInset)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Layout.buttonBottomInset)
        }
        continueButton.setStyle(.primary, size: .xl)
        continueButton.addTarget(
            self,
            action: #selector(continueButtonTapped),
            for: .touchUpInside
        )
    }

    func updateBottomInsets() {
        let bottomInset = collectionBottomInset
        collectionView.contentInset.bottom = bottomInset
        collectionView.verticalScrollIndicatorInsets.bottom = bottomInset
    }

    @objc
    func continueButtonTapped() {
        presenter?.didTapContinue()
    }
}

private extension RestrictionSetupViewController {
    var collectionBottomInset: CGFloat {
        continueButton.bounds.height
            + Layout.buttonTopInset
            + Layout.buttonBottomInset
            + view.safeAreaInsets.bottom
    }

    var collectionBottomAnchorItem: ConstraintRelatableTarget {
        if #available(iOS 18.0, *) {
            view.snp.bottom
        } else {
            view.safeAreaLayoutGuide.snp.bottom
        }
    }
}
