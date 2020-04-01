//
//  PullRequestDetailView.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class PullRequestDetailView: UIView {
    let firstContainer = UIView()
    let secondContainer = UIView()
    var scrollView = UIScrollView()
    var contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        setupScrollView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(scrollView)
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }

    func setupViews(descriptionText: String) {
        let stackView = UIStackView(arrangedSubviews: [firstContainer, secondContainer, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 25
        contentView.addSubview(stackView)

        let secondContainerHeight: CGFloat = 85 + descriptionText.height(withConstrainedWidth: frame.width - 38,
                                                                         font: .systemFont(ofSize: 14))

        firstContainer.heightAnchor.constraint(equalToConstant: 195).isActive = true
        secondContainer.heightAnchor.constraint(equalToConstant: secondContainerHeight).isActive = true

        stackView.fillSuperview()

        secondContainer.accessibilityIdentifier = "secondContainerID"
    }

    func setUpContainersSubviews(item: PullRequestDetailViewModelItem) {
        let pullRequestInfoView = PullRequestInfoView(item: item)
        firstContainer.addSubview(pullRequestInfoView)
        pullRequestInfoView.fillSuperview()

        let pullRequestUserInfoView = PullRequestUserInfoView(item: item)
        secondContainer.addSubview(pullRequestUserInfoView)
        pullRequestUserInfoView.fillSuperview()
    }
}
