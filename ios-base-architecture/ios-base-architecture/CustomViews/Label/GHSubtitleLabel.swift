//
//  GHSubtitleLabel.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class GHSubtitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        font = UIFont.systemFont(ofSize: 17, weight: .bold)
        minimumScaleFactor = 0.9
        numberOfLines = 1
        adjustsFontSizeToFitWidth = true
        textColor = .darkGray
    }
}
