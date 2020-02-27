//
//  GHDefaultSystemImageView.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

import UIKit

class GHDefaultSystemImageView: UIImageView {    
    
    override init(image: UIImage?) {
        super.init(image: image)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        contentMode = .scaleAspectFit
        tintColor = .systemGray
    }
}
