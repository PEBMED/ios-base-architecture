//
//  GHAvatarImageView.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHAvatarImageView: UIImageView {
    let size: CGSize
    
    init(size: CGSize) {
        self.size = size
        super.init(frame: .zero)
        setupLayout()
    }
    
    override var intrinsicContentSize: CGSize{
        return size
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        layer.cornerRadius = size.height/2
        contentMode = .scaleToFill
        clipsToBounds = true
        image = #imageLiteral(resourceName: "avatar-placeholder-dark")
    }
}
