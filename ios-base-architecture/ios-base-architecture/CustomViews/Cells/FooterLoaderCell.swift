//
//  FooterLoaderCell.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class FooterLoaderCell: UICollectionReusableView {        
    
    let loader: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView(style: .medium)
        ac.color = .systemGray
        return ac
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        self.addSubview(loader)
        loader.centerInSuperview()
        
        loader.startAnimating()
    }
}
