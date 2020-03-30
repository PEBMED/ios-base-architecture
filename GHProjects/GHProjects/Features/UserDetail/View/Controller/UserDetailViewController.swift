//
//  UserDetailViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class UserDetailViewController: UICollectionViewController {
    // MARK: - Properties
    private let viewModel: UserDetailViewModel
    private let coordinator: UserDetailCoordinatorProtocol

    // MARK: - Init
    init(viewModel: UserDetailViewModel, coordinator: UserDetailCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
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
        setupTargets()
        registerCollectionViewCells()
        getUserDetail()
    }

    // MARK: - Private functions
    private func setupController() {
        collectionView.backgroundColor = .systemGroupedBackground
    }

    private func setupTargets() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(didSelectCloseButton))

        //customView.profileButton.addTarget(self, action: #selector(didSelectButton), for: .touchUpInside)
    }

    private func registerCollectionViewCells() {
        collectionView.register(UserDetailHeaderCell.self)
        collectionView.register(UserReposCollectionViewCell.self)
    }

    private func getUserDetail() {
        showLoader()
        viewModel.fetchUserDetail { success, errorMessage in
            self.removeLoader()
            guard success else {
                self.showDefaultAlertOnMainThread(title: GHError.titleError.rawValue,
                                                  message: errorMessage ?? GHError.genericError.rawValue)
                return
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: - Actions
    @objc private func didSelectButton() {
        coordinator.goToProfile(stringUrl: viewModel.getUserViewModelItem()?.profileUrl ?? "")
    }

    @objc private func didSelectCloseButton() {
        coordinator.closeViewController()
    }
}

// MARK: - UICollectionViewDataSource
extension UserDetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getUserViewModelItem() == nil ? 0 : 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as UserDetailHeaderCell
            if let viewModelItem = viewModel.getUserViewModelItem() {
                cell.setupViews(viewModelItem: viewModelItem)
            }
            return cell
        }
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as UserReposCollectionViewCell
        cell.setupCollectionView(viewModel: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UserDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = indexPath.item == 0 ? 294 : ((view.frame.width - 70) * 0.56) + 76
        return CGSize(width: view.frame.width, height: size)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
