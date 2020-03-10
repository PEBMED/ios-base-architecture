//
//  PullRequestUserInfoController.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class PullRequestUserInfoView: UIView {
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        return label
    }()

    let userLoginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()

    let avatarImageView = GHAvatarImageView(size: CGSize(width: 6, height: 6))

    let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.setTitleColor(.systemGray2, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    init(item: PullRequestDetailViewModelItem) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupViews()
        set(item: item)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubviews(avatarImageView, menuButton, descriptionLabel)

        avatarImageView.anchor(top: topAnchor, leading: leadingAnchor, padding: UIEdgeInsets(top: 12, left: 18, bottom: 0, right: 0))
        avatarImageView.anchor(height: 27, width: 27)

        menuButton.anchor(top: topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 14))

        let titleLabelsStackView = UIStackView(arrangedSubviews: [userLoginLabel, dateLabel])
        titleLabelsStackView.axis = .vertical
        titleLabelsStackView.spacing = 2

        addSubview(titleLabelsStackView)
        titleLabelsStackView.anchor(top: avatarImageView.topAnchor,
                                    leading: avatarImageView.trailingAnchor,
                                    trailing: trailingAnchor,
                                    padding: UIEdgeInsets(top: -2, left: 10, bottom: 0, right: 14))

        descriptionLabel.anchor(top: avatarImageView.bottomAnchor,
                                leading: avatarImageView.leadingAnchor,
                                trailing: trailingAnchor,
                                padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20))
    }

    func set(item: PullRequestDetailViewModelItem) {
        dateLabel.text = item.createdAt
        userLoginLabel.text = item.userName
        descriptionLabel.text = item.body

        avatarImageView.fetchImage(stringUrl: item.headAvatarUrl)
    }
}
