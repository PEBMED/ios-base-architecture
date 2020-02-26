//
//  ViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class RepositoriesCollectionViewController: UICollectionViewController {
    
    let cellID = "cellID"
    let footerCellID = "footerCellID"
    let viewModel: RepositoryViewModel
    
    init(viewModel: RepositoryViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        registerCells()
        getRepositories()
    }
    
    func setupController(){
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        navigationItem.searchController = UISearchController()
    }
    
    func registerCells() {
        collectionView.register(RepositoryCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(FooterLoaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: footerCellID)
    }
    
    func getRepositories() {
        guard viewModel.hasMoreData else { return }

        viewModel.fetchRepositories { [weak self](success, errorMessage) in
            guard success else {
                self?.showDefaultAlertOnMainThread(title: "Erro", message: errorMessage ?? "")
                return
            }
            self?.reloadDataOnMainThread()
        }
    }
}


extension RepositoriesCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return RepositoryCollectionViewCell.getCellHeight(with: viewModel.getRepositoryViewModelItem(with: indexPath).description)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}

extension RepositoriesCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRepositoryViewModelNumberOfItems()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? RepositoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        let removeSeparator = indexPath.item == viewModel.getRepositoryViewModelNumberOfItems()-1
        cell.set(item: viewModel.getRepositoryViewModelItem(with: indexPath), removeSeparator: removeSeparator)        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCellID, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let height = viewModel.hasMoreData ? 40 : 0
        return CGSize(width: 0, height: height)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.getRepositoryViewModelNumberOfItems()-1 == indexPath.item {
            getRepositories()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let searchRepository = viewModel.getSearchRepository() else {return}
        let viewModel = DefaultPullRequestViewModel(searchRepository.items[indexPath.item], service: DefaultPullRequestService())
        let pullRequestController = PullRequestCollectionViewController(viewModel: viewModel)
        navigationController?.pushViewController(pullRequestController, animated: true)
    }
}
