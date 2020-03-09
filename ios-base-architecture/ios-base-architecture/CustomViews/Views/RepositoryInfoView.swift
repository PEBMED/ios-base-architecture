//
//  ProjectInfoView.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class RepositoryInfoView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        imageView.heightAnchor.constraint(equalToConstant: 19).isActive = true

        let stackView = UIStackView(arrangedSubviews: [imageView, numberLabel])
        stackView.spacing = 6
        stackView.alignment = .center

        addSubviews(stackView)
        stackView.fillSuperview()
    }

    func set(imageName: String, value: Int) {
        self.imageView.image = UIImage(systemName: imageName)
        self.numberLabel.text = String(value)
    }
}
