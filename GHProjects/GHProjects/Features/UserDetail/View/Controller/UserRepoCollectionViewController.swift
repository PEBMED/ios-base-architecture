//
//  UserRepoCollectionViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 19/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class UserRepoCollectionViewController: UICollectionViewController {
    // MARK: - Properties
    private let viewModel: UserDetailViewModel

    // MARK: - Init
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupCollectionView()
    }

    // MARK: - Private functions
    private func setupCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
    }

    private func registerCells() {
        collectionView.register(RepoCollectionViewCell.self)
    }
}

// MARK: - UICollectionViewDataSource
extension UserRepoCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as RepoCollectionViewCell
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UserRepoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 70
        return CGSize(width: width, height: width * 0.55)
    }
}
