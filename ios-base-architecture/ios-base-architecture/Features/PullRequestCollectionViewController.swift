//
//  PullRequestCollectionViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit 

class PullRequestCollectionViewController: UICollectionViewController {
    
    let cellID = "cellID"
    let footerCellID = "footerCellID"
    let viewModel: PullRequestViewModel
    
    init(viewModel: PullRequestViewModel){
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
        getPullRequests()
    }
    
    func getPullRequests(){
        viewModel.fetchPullRequests { [weak self] (success, message) in
            guard success else {
                self?.showDefaultAlertOnMainThread(title: "Erro", message: message ?? "")
                return
            }
            
            self?.reloadDataOnMainThread()
        }
    }
    
    func setupController(){
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)        
        self.title = viewModel.projectName
    }
    
    func registerCells(){
        collectionView.register(PullRequestCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(FooterLoaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellID)
    }
}

extension PullRequestCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return PullRequestCollectionViewCell.getCellHeight(with: viewModel.getPullRequestViewModelItem(with: indexPath).body ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}

extension PullRequestCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPullRequestViewModelNumberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PullRequestCollectionViewCell
        let removeSeparator = (viewModel.getPullRequestViewModelNumberOfItems()-1) == indexPath.item
        cell.set(item: viewModel.getPullRequestViewModelItem(with: indexPath), removeSeparator: removeSeparator)
        return cell
    }
}
