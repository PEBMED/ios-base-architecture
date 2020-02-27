//
//  GHTitleLabel.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        font = UIFont.systemFont(ofSize: 19, weight: .heavy)
        minimumScaleFactor = 0.8
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
    }
}
