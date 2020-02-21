//
//  ViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class ProjectsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var itens = ["", "", "", "", ""]
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        registerCells()
    }
    
    func setupController(){
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Projects"
    }
    
    func registerCells(){
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itens.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
}


class ProjectsCollectionViewCell: UICollectionViewCell {
    
}
