//
//  PullRequestDetailView.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class PullRequestDetailView: UIView {
    let firstContainer = UIView()
    let secondContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemGray6        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        addSubview(firstContainer)
        addSubview(secondContainer)
                
        firstContainer.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, size: CGSize(width: 0, height: 195))
        
        secondContainer.anchor(top: firstContainer.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 260))
    }
    
    func setUpContainersSubviews(item: PullRequestDetailViewModelItem){
        let pullRequestInfoView = PullRequestInfoView(item: item)
        firstContainer.addSubview(pullRequestInfoView)
        pullRequestInfoView.fillSuperview()

        let pullRequestUserInfoView = PullRequestUserInfoView(item: item)
        secondContainer.addSubview(pullRequestUserInfoView)
        pullRequestUserInfoView.fillSuperview()
    }
}
