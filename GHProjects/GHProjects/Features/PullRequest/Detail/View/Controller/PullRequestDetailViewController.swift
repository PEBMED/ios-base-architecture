//
//  PullRequestDetailViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 26/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class PullRequestDetailViewController: GHCustomViewController<PullRequestDetailView> {
    // MARK: - Properties
    private let coordinator: PullRequestDetailCoordinatorProtocol
    private let viewModel: PullRequestDetailsViewModel

    // MARK: - Init
    init(coordinator: PullRequestDetailCoordinatorProtocol, viewModel: PullRequestDetailsViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        getPullRequestDetail()
        customView.secondContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelecUserInfo)))
    }

    // MARK: - Private functions
    private func setupController() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Pull Request Detail"
    }

    private func getPullRequestDetail() {
        showLoader()
        viewModel.fetchPullRequests { [weak self] success, error in
            self?.removeLoader()
            guard success else {
                self?.showDefaultAlertOnMainThread(title: GHError.titleError.rawValue, message: error ?? GHError.genericError.rawValue)
                return
            }

            guard let viewModelItem = self?.viewModel.getPullRequestDetailViewModelItem() else { return }

            DispatchQueue.main.async {
                self?.customView.setupViews(descriptionText: viewModelItem.body)
                self?.customView.setUpContainersSubviews(item: viewModelItem)
            }
        }
    }

    @objc func didSelecUserInfo() {
        guard let userName = viewModel.getPullRequestDetailViewModelItem()?.userName else { return }
        coordinator.goToUserDetail(userName: userName)
    }

    // MARK: - Deinit
    deinit {
        debugPrint("DEINIT PullRequestDetailViewController")
    }
}
