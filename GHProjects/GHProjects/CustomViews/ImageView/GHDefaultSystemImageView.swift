//
//  GHDefaultSystemImageView.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

import UIKit

final class GHDefaultSystemImageView: UIImageView {
    override init(image: UIImage?) {
        super.init(image: image)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentMode = .scaleAspectFit
        tintColor = .systemGray
    }
}
