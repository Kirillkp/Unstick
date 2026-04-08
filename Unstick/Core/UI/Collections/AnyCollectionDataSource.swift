//
//  AnyCollectionDataSource.swift
//  Unstick
//
//  Created by Codex on 07.04.2026.
//

import UIKit

final class AnyCollectionDataSource: UICollectionViewDiffableDataSource<AnyCollectionSection, AnyCollectionItem> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<AnyCollectionSection, AnyCollectionItem>
    typealias SectionModel = AnyCollectionSection

    private weak var collectionViewReference: UICollectionView?
    private var sections: [SectionModel] = []
    private var registeredReuseIdentifiers: Set<String> = []

    init(collectionView: UICollectionView) {
        collectionViewReference = collectionView
        super.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: itemIdentifier.viewModel.cellIdentifier,
                for: indexPath
            )

            if let configurableCell = cell as? ConfigurableView {
                configurableCell.configure(with: itemIdentifier.viewModel)
            }

            return cell
        }

        self.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard
                let self,
                sections.indices.contains(indexPath.section),
                let supplementaryView = sections[indexPath.section].supplementaryItem
            else {
                return nil
            }

            let reusableView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: supplementaryView.cellIdentifier,
                for: indexPath
            )

            if let configurableView = reusableView as? ConfigurableView {
                configurableView.configure(with: supplementaryView.viewModel)
            }

            return reusableView
        }
    }
}

extension AnyCollectionDataSource {
    func setSections(with sections: [SectionModel]) {
        registerReusableViewsIfNeeded(for: sections)
        self.sections = sections
    }

    func clearSections() {
        sections = []
    }

    func applySnapshot(
        animatingDifferences: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        var snapshot = Snapshot()
        snapshot.appendSections(sections)

        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }

        apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
    }

    @MainActor
    private func registerReusableViewsIfNeeded(for sections: [SectionModel]) {
        guard let collectionView = collectionViewReference else { return }

        for section in sections {
            if let supplementaryItem = section.supplementaryItem {
                registerIfNeeded(supplementaryItem.viewModel.registration, in: collectionView)
            }

            for item in section.items {
                registerIfNeeded(item.viewModel.registration, in: collectionView)
            }
        }
    }

    @MainActor
    private func registerIfNeeded(
        _ registration: CollectionReusableRegistration,
        in collectionView: UICollectionView
    ) {
        guard registeredReuseIdentifiers.insert(registration.reuseIdentifier).inserted else { return }
        registration.register(collectionView)
    }
}
