//
//  PullRequestCollectionViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class PullRequestCollectionViewController: UICollectionViewController {
    private let viewModel: PullRequestViewModel

    init(viewModel: PullRequestViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        registerCells()
        getPullRequests()
    }

    func setupController() {
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        self.title = viewModel.repoName
    }

    func registerCells() {
        collectionView.register(PullRequestCollectionViewCell.self)
        collectionView.register(FooterLoaderCell.self, ofKind: UICollectionView.elementKindSectionFooter)
    }

    func getPullRequests() {
        guard viewModel.hasMoreData else { return }

        viewModel.fetchPullRequests { [weak self] success, message in
            guard success else {
                self?.showDefaultAlertOnMainThread(title: GHError.titleError.rawValue, message: message ?? GHError.genericError.rawValue)
                return
            }
            self?.reloadDataOnMainThread()
        }
    }

    deinit {
        debugPrint("Deinit PullRequestCollectionViewController")
    }
}

extension PullRequestCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PullRequestCollectionViewCell.getCellHeight(with: viewModel.getPullRequestViewModelItem(with: indexPath).body ?? "")
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: viewModel.hasMoreData ? 44 : 0)
    }
}

extension PullRequestCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPullRequestViewModelNumberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PullRequestCollectionViewCell
        let removeSeparator = (viewModel.getPullRequestViewModelNumberOfItems() - 1) == indexPath.item
        cell.set(item: viewModel.getPullRequestViewModelItem(with: indexPath), removeSeparator: removeSeparator)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, indexPath: indexPath) as FooterLoaderCell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 willDisplay cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        if viewModel.getPullRequestViewModelNumberOfItems() - 1 == indexPath.item {
            getPullRequests()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(viewModel.didSelectPullRequest(indexPath: indexPath), animated: true)
    }
}
