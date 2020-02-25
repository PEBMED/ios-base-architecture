//
//  GHSubtitleLabel.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHSubtitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
        font = UIFont.systemFont(ofSize: 17, weight: .bold)
        minimumScaleFactor = 0.9
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        textColor = .darkGray
    }
}
