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
        viewModel.fetchPullRequests { (success, error) in
            print(success)
        }
    }
    
    func setupController(){
        navigationItem.largeTitleDisplayMode = .never
    }
}
