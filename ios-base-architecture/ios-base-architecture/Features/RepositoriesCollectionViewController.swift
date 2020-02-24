//
//  ViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class RepositoriesCollectionViewController: UICollectionViewController {

    var itens = [Repository]()
    let cellID = "cellID"
    let viewModel: RepositoryViewModel
    
    init(viewModel: RepositoryViewModel){
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
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)        
    }
    
    func registerCells(){
        collectionView.register(ProjectsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    func getRepositories(){
        showLoader()
        viewModel.fetchRepositories { [weak self](success, errorMessage) in
            self?.removeLoader()
            guard success else {
                self?.showDefaultAlertOnMainThread(title: "Erro", message: errorMessage ?? "")
                return
            }
            self?.reloadDataOnMainThread()
        }
    }
}


extension RepositoriesCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ProjectsCollectionViewCell.getCellHeight(with: viewModel.getRepositoryViewModelItem(with: indexPath).description)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 14
    }
}

extension RepositoriesCollectionViewController{
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getRepositoryViewModelNumberOfItems()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ProjectsCollectionViewCell
        let removeSeparator = indexPath.item == viewModel.getRepositoryViewModelNumberOfItems()-1
        cell.set(item: viewModel.getRepositoryViewModelItem(with: indexPath), removeSeparator: removeSeparator)
        return cell
    }
}
