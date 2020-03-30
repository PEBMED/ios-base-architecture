//
//  RepoCollectionViewCell.swift
//  ios-base-architecture
//
//  Created by Luiz on 19/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class RepoCollectionViewCell: UICollectionViewCell {
    // MARK: - Views
    private let avatarImageView: GHAvatarImageView = {
        let imageView = GHAvatarImageView(size: CGSize(width: 22, height: 22))
        imageView.layer.cornerRadius = 5
        imageView.heightAnchor.constraint(equalToConstant: 22).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
        imageView.backgroundColor = .red
        return imageView
    }()

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "luizhammerli"
        return label
    }()

    private let projectNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "OnTheMap"
        return label
    }()

    private let languageNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.text = "Javascript"
        return label
    }()

    private let startsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 16)
        label.text = "0"
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions
    private func setupViews() {
        layer.cornerRadius = 4
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray4.cgColor
        backgroundColor = .systemBackground

        setupHeader()
        setupBottomView()
    }

    private func setupHeader() {
        let horizontalStackView = UIStackView(arrangedSubviews: [avatarImageView, loginLabel])
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 8

        addSubviews(horizontalStackView, projectNameLabel)

        horizontalStackView.anchor(top: topAnchor,
                                   leading: leadingAnchor,
                                   bottom: nil,
                                   trailing: trailingAnchor,
                                   padding: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15))

        projectNameLabel.anchor(top: horizontalStackView.bottomAnchor,
                                leading: horizontalStackView.leadingAnchor,
                                bottom: nil,
                                trailing: horizontalStackView.trailingAnchor,
                                padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }

    private func setupBottomView() {
        let circleImageView = UIImageView()
        circleImageView.image = UIImage(systemName: "circle.fill")
        circleImageView.tintColor = #colorLiteral(red: 0.9607843137, green: 0.7176470588, blue: 0.3882352941, alpha: 1)
        circleImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        circleImageView.widthAnchor.constraint(equalToConstant: 17).isActive = true

        let languageInfoStackView = UIStackView(arrangedSubviews: [circleImageView, languageNameLabel])
        languageInfoStackView.alignment = .center
        languageInfoStackView.spacing = 5

        let starImageView = UIImageView()
        starImageView.image = UIImage(systemName: "star.fill")
        starImageView.tintColor = .systemYellow
        starImageView.heightAnchor.constraint(equalToConstant: 17).isActive = true
        starImageView.widthAnchor.constraint(equalToConstant: 17).isActive = true

        let starsInfoStackView = UIStackView(arrangedSubviews: [starImageView, startsCountLabel])
        starsInfoStackView.alignment = .center
        starsInfoStackView.spacing = 5

        let mainStackView = UIStackView(arrangedSubviews: [languageInfoStackView, starsInfoStackView])
        mainStackView.distribution = .equalSpacing

        addSubview(mainStackView)
        mainStackView.anchor(leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
    }
}
