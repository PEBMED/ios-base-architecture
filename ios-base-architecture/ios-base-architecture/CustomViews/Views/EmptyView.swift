//
//  EmptyView.swift
//  ios-base-architecture
//
//  Created by Luiz on 03/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHEmptyView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "lauch-image"))
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()

    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()

    init(text: String) {
        label.text = text
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.spacing = 4

        addSubview(stackView)
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 30, bottom: 0, right: 30))
        stackView.centerYInSuperview()
    }
}
