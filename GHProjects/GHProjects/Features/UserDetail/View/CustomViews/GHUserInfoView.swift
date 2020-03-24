//
//  GHUserInfoView.swift
//  ios-base-architecture
//
//  Created by Luiz on 15/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHUserInfoView: UIView {
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .darkGray
        imageView.widthAnchor.constraint(equalToConstant: 21).isActive = true
        return imageView
    }()

    let nameLabel = UILabel()

    init(color: UIColor, icon: UIImage, bold: Bool = false) {
        super.init(frame: .zero)
        setupViews()
        setData(color: color, icon: icon, bold: bold)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(color: UIColor, icon: UIImage, bold: Bool) {
        nameLabel.font = bold ? .boldSystemFont(ofSize: 14) : .systemFont(ofSize: 14)
        iconImageView.image = icon
        iconImageView.tintColor = color
    }

    func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, nameLabel])
        stackView.spacing = 6
        stackView.alignment = .center

        addSubview(stackView)
        stackView.fillSuperview()
    }
}