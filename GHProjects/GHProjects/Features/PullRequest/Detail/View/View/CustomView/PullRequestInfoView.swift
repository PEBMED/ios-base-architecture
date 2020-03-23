//
//  PullRequestInfoViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class PullRequestInfoView: UIView {
    let logoImageView = GHAvatarImageView(size: CGSize(width: 16, height: 16))

    let originBranchNameView = BranchNameView()
    let destinationBranchNameView = BranchNameView()
    let branchStateView = BranchStateView()
    let footerContainerView = UIView()

    let repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .darkGray
        return label
    }()

    let repositoryNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let filesChangedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    let reviewChangesLabel: UILabel = {
        let label = UILabel()
        label.text = "Review changes"
        label.font = .systemFont(ofSize: 11)
        label.textColor = .systemBlue
        return label
    }()

    let deleteAddLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    init(item: PullRequestDetailViewModelItem) {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupViews()
        set(with: item)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        setupHeader()
        setupBanchView()
        setupFooterContainerView()
    }

    func setupHeader() {
        addSubviews(logoImageView, repositoryNameLabel, repositoryNumberLabel, titleLabel)
        logoImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
                             leading: leadingAnchor,
                             bottom: nil,
                             trailing: nil,
                             padding: UIEdgeInsets(top: 14, left: 14, bottom: 0, right: 0))
        logoImageView.anchor(height: 15, width: 15)

        repositoryNameLabel.anchor(top: nil,
                                   leading: logoImageView.trailingAnchor,
                                   bottom: nil,
                                   trailing: nil,
                                   padding: UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 10))
        repositoryNameLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor).isActive = true

        repositoryNumberLabel.anchor(top: nil,
                                     leading: repositoryNameLabel.trailingAnchor,
                                     bottom: nil,
                                     trailing: nil,
                                     padding: UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 10))
        repositoryNumberLabel.centerYAnchor.constraint(equalTo: logoImageView.centerYAnchor).isActive = true

        titleLabel.anchor(top: repositoryNumberLabel.bottomAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: UIEdgeInsets(top: 13, left: 15, bottom: 0, right: 10))
    }

    func setupBanchView() {
        let arrowImage = GHDefaultSystemImageView(image: UIImage(systemName: "arrow.right"))

        let branchNameStackView = UIStackView(arrangedSubviews: [originBranchNameView, arrowImage, destinationBranchNameView, UIView()])
        branchNameStackView.alignment = .center

        addSubviews(branchNameStackView, branchStateView)

        branchNameStackView.anchor(top: titleLabel.bottomAnchor,
                                   leading: titleLabel.leadingAnchor,
                                   trailing: self.trailingAnchor,
                                   padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 10))

        arrowImage.anchor(height: 17, width: 25)

        branchStateView.anchor(top: destinationBranchNameView.bottomAnchor,
                               leading: originBranchNameView.leadingAnchor,
                               bottom: nil,
                               trailing: nil,
                               padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }

    func setupFooterContainerView() {
        let separator = SeparatorView()
        let chevronImage = GHDefaultSystemImageView(image: SFSymbols.chevron)

        addSubviews(footerContainerView, separator, chevronImage)

        footerContainerView.anchor(top: branchStateView.bottomAnchor,
                                   leading: leadingAnchor,
                                   bottom: bottomAnchor,
                                   trailing: trailingAnchor,
                                   padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))

        separator.anchor(top: footerContainerView.topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        separator.anchor(height: 1)

        chevronImage.anchor(trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
        chevronImage.anchor(height: 14, width: 14)
        chevronImage.centerY(in: footerContainerView)

        setupFilesChangedLabel()
        setupDeleteAddLabel()
    }

    func setupFilesChangedLabel() {
        let labelStackView = UIStackView(arrangedSubviews: [filesChangedLabel, reviewChangesLabel])
        labelStackView.axis = .vertical
        labelStackView.spacing = 2

        footerContainerView.addSubviews(labelStackView, deleteAddLabel)
        labelStackView.anchor(leading: leadingAnchor, padding: UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0))
        labelStackView.centerY(in: footerContainerView)
    }

    func setupDeleteAddLabel() {
        footerContainerView.addSubview(deleteAddLabel)

        deleteAddLabel.centerYInSuperview()
        deleteAddLabel.anchor(trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 32))
    }

    func set(with item: PullRequestDetailViewModelItem) {
        destinationBranchNameView.branchNameLabel.text = item.baseBranchName
        originBranchNameView.branchNameLabel.text = item.headBranchName
        repositoryNameLabel.text = item.fullName
        repositoryNumberLabel.text = item.number
        titleLabel.text = item.title
        filesChangedLabel.text = item.changedFiles
        deleteAddLabel.attributedText = item.additionsDeletions

        logoImageView.fetchImage(stringUrl: item.baseAvatarUrl)
    }
}
