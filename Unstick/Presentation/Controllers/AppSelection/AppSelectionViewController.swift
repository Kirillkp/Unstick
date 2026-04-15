//
//  AppSelectionViewController.swift
//  Unstick
//
//  Created by Codex on 10.04.2026.
//

import UIKit
import SnapKit
import FamilyControls
import SwiftUI

final class AppSelectionViewController: UIViewController {
    private enum Layout {}

    var presenter: AppSelectionPresenterProtocol?

    private let collectionView = ContentSizedCollectionView(
        frame: .zero,
        collectionViewLayout: AppSelectionCollectionLayoutBuilder.makeLayout()
    )
    private let continueButton = DSButton()
    private var onPickerSelectionUpdated: ((FamilyActivitySelection) -> Void)?

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

extension AppSelectionViewController: AppSelectionViewProtocol {
    var _collectionView: UICollectionView {
        collectionView
    }

    func setContinueEnabled(_ isEnabled: Bool) {
        continueButton.isEnabled = isEnabled
        continueButton.alpha = isEnabled ? 1 : 0.72
    }

    func refreshCollectionLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        view.layoutIfNeeded()
    }

    func setSelectAppsActionEnabled(_ isEnabled: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = isEnabled
    }

    func presentFamilyActivityPicker(
        selection: FamilyActivitySelection,
        onSelectionUpdated: @escaping (FamilyActivitySelection) -> Void
    ) {
        onPickerSelectionUpdated = onSelectionUpdated
        let pickerView = AppSelectionFamilyPickerView(
            initialSelection: selection,
            onSelectionUpdated: { [weak self] updatedSelection in
                self?.onPickerSelectionUpdated?(updatedSelection)
            },
            onClose: { [weak self] in
                self?.dismiss(animated: true)
            }
        )
        let hostingController = UIHostingController(rootView: pickerView)
        hostingController.modalPresentationStyle = .formSheet
        present(hostingController, animated: true)
    }
}

private extension AppSelectionViewController {
    func createUI() {
        setupSelf()
        setupCollectionView()
        setupContinueButton()
    }

    func setupSelf() {
        view.backgroundColor = DS.Colors.neutral
        title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: L10n.GroupInsight.Action.selectApps,
            style: .plain,
            target: self,
            action: #selector(selectAppsButtonTapped)
        )
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
            $0.horizontalEdges.equalToSuperview().inset(DS.Spacing.x24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(DS.Spacing.x16)
        }
        continueButton.setStyle(.primary, size: .xl)
        continueButton.setTitle(L10n.Common.next, for: .normal)
        setContinueEnabled(false)
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

    @objc
    func selectAppsButtonTapped() {
        presenter?.didTapSelectApps()
    }
}

private extension AppSelectionViewController {
    var collectionBottomInset: CGFloat {
        continueButton.bounds.height
            + DS.Spacing.x16
            + DS.Spacing.x16
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

private struct AppSelectionFamilyPickerView: View {
    @State private var selection: FamilyActivitySelection
    @State private var didCommitSelection = false
    private let onSelectionUpdated: (FamilyActivitySelection) -> Void
    private let onClose: () -> Void

    init(
        initialSelection: FamilyActivitySelection,
        onSelectionUpdated: @escaping (FamilyActivitySelection) -> Void,
        onClose: @escaping () -> Void
    ) {
        _selection = State(initialValue: initialSelection)
        self.onSelectionUpdated = onSelectionUpdated
        self.onClose = onClose
    }

    var body: some View {
        NavigationStack {
            FamilyActivityPicker(selection: $selection)
                .navigationTitle(L10n.GroupInsight.Action.selectApps)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Done") {
                            didCommitSelection = true
                            onSelectionUpdated(selection)
                            onClose()
                        }
                    }
                }
                .onDisappear {
                    guard !didCommitSelection else { return }
                    onSelectionUpdated(selection)
                }
        }
    }
}
