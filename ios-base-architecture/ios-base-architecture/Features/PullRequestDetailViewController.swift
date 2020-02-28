//
//  PullRequestDetailViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 26/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class PullRequestDetailViewController: GHCustomViewController<PullRequestDetailView> {
    
    let viewModel: PullRequestDetailsViewModel
    
    init(viewModel: PullRequestDetailsViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        getPullRequestDetail()
    }
    
    func setupController(){
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func getPullRequestDetail(){
        showLoader()
        viewModel.fetchPullRequests { [weak self](success, error) in
            self?.removeLoader()
            guard success else {
                self?.showDefaultAlertOnMainThread(title: GHError.titleError.rawValue, message: error ?? GHError.genericError.rawValue)
                return
            }
            
            guard let viewModelItem = self?.viewModel.getPullRequestDetailViewModelItem() else {return}
            
            DispatchQueue.main.async {
                self?.customView.setupViews(descriptionText: viewModelItem.body)
                self?.customView.setUpContainersSubviews(item: viewModelItem)
            }
        }
    }
    
}
