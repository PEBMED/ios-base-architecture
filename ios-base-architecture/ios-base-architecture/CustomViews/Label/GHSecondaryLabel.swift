//
//  GHSecondaryLabel.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHSecondaryLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        font = UIFont.systemFont(ofSize: 16)
        minimumScaleFactor = 0.9
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        textColor = .systemGray
    }
}
