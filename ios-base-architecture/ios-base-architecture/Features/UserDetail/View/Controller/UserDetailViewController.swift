//
//  UserDetailViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class UserDetailViewController: GHCustomViewController <UserDetailView> {
    let viewModel: UserDetailViewModel
    let coordinator: UserDetailCoordinatorProtocol

    init(viewModel: UserDetailViewModel, coordinator: UserDetailCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        getUserDetail()
    }

    func setupTargets() {
        customView.profileButton.addTarget(self, action: #selector(didSelectButton), for: .touchUpInside)
    }

    func getUserDetail() {
        showLoader()
        viewModel.fetchUserDetail { viewModelItem, errorMessage in
            self.removeLoader()
            guard let viewModelItem = viewModelItem else {
                print("errorMessage:\( errorMessage ?? GHError.genericError.rawValue )")
                return
            }
            DispatchQueue.main.async {
                self.customView.setupViews(viewModelItem: viewModelItem)
            }
        }
    }

    @objc
    func didSelectButton() {
        coordinator.goToProfile(stringUrl: viewModel.getUserViewModelItem()?.profileUrl ?? "")
    }
}
