//
//  RepositoriesListViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class RepositoriesListViewController: UICollectionViewController {
    private let coordinator: RepositoriesListCoordinatorProtocol
    private let viewModel: RepositoryViewModel

    // MARK: - Init
    init(coordinator: RepositoriesListCoordinatorProtocol, viewModel: RepositoryViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        registerCells()
        getRepositories()
    }

    // MARK: - Private functions
    private func setupController() {
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        navigationItem.searchController = UISearchController()
    }

    private func registerCells() {
        collectionView.register(RepositoryCollectionViewCell.self)
        collectionView.register(FooterLoaderCell.self, ofKind: UICollectionView.elementKindSectionFooter)
    }

    private func getRepositories() {
        guard viewModel.hasMoreData else { return }

        viewModel.fetchRepositories { [weak self] success, errorMessage in
            guard success else {
                self?.showDefaultAlertOnMainThread(title: GHError.titleError.rawValue,
                                                   message: errorMessage ?? GHError.genericError.rawValue)
                return
            }
            self?.reloadDataOnMainThread()
        }
    }

    deinit {
        debugPrint("Deinit RepositoriesListViewController")
    }
}

extension RepositoriesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel.getRepositoryViewModelItem(with: indexPath).description
        return RepositoryCollectionViewCell.getCellHeight(with: text)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate & UICollectionViewFlowLayoutDelegate
extension RepositoriesListViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRepositoryViewModelNumberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as RepositoryCollectionViewCell
        let removeSeparator = indexPath.item == viewModel.getRepositoryViewModelNumberOfItems() - 1
        cell.set(item: viewModel.getRepositoryViewModelItem(with: indexPath), removeSeparator: removeSeparator)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, indexPath: indexPath) as FooterLoaderCell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let height = viewModel.hasMoreData ? 40 : 0
        return CGSize(width: 0, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        if viewModel.getRepositoryViewModelNumberOfItems() - 1 == indexPath.item {
            getRepositories()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModelItem = viewModel.getRepositoryViewModelItem(with: indexPath)
        coordinator.goToPullRequestList(viewModelItem: viewModelItem)
    }
}
