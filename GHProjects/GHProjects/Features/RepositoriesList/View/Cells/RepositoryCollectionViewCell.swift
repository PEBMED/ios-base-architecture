//
//  ProjectsCollectionViewCell.swift
//  ios-base-architecture
//
//  Created by Luiz on 23/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class RepositoryCollectionViewCell: UICollectionViewCell {
    let titleLabel = GHTitleLabel()
    let companyLabel = GHSecondaryLabel()
    let desciprionLabel = GHBodyLabel()

    let startsRepositoryView = RepositoryInfoView()
    let forkRepositoryView = RepositoryInfoView()
    let issuesRepositoryView = RepositoryInfoView()

    let separatorView = SeparatorView()
    let avatarImageView = GHAvatarImageView(size: CGSize(width: 60, height: 60))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func getCellHeight(with text: String) -> CGSize {
        let padding: CGFloat = 36
        let label = GHBodyLabel()
        label.text = text
        let labelHeight = label.height(width: UIScreen.main.bounds.width - 108)
        let height: CGFloat = 112 + (labelHeight - 36)
        return CGSize(width: UIScreen.main.bounds.width - padding, height: height)
    }

    func setupViews() {
        setupHeaderViews()
        setupProjectInfoStackView()
    }

    func setupHeaderViews() {
        avatarImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true

        let titleLabelStackView = UIStackView(arrangedSubviews: [titleLabel, companyLabel, UIView()])
        titleLabelStackView.spacing = 8
        titleLabelStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        let labelsStackView = UIStackView(arrangedSubviews: [titleLabelStackView, desciprionLabel])
        labelsStackView.axis = .vertical
        labelsStackView.isLayoutMarginsRelativeArrangement = true
        labelsStackView.layoutMargins = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        labelsStackView.spacing = 6

        let headerStackView = UIStackView(arrangedSubviews: [avatarImageView, labelsStackView])
        headerStackView.alignment = .top
        headerStackView.spacing = 12

        addSubviews(headerStackView)

        headerStackView.anchor(top: topAnchor,
                               leading: leadingAnchor,
                               bottom: nil,
                               trailing: trailingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }

    func setupProjectInfoStackView() {
        let stackView = UIStackView(arrangedSubviews: [startsRepositoryView, forkRepositoryView, issuesRepositoryView, UIView()])
        stackView.distribution = .equalSpacing

        addSubviews(stackView, separatorView)

        stackView.anchor(top: desciprionLabel.bottomAnchor,
                         leading: titleLabel.leadingAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 14))
        stackView.anchor(height: 19)

        separatorView.anchor(top: stackView.bottomAnchor,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             padding: UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0))
        separatorView.anchor(height: 1)
    }

    func set(item: RepositoryViewModelItem, removeSeparator: Bool, index: Int) {
        titleLabel.text = item.name
        companyLabel.text = item.ownerName
        desciprionLabel.text = item.description

        startsRepositoryView.set(imageName: "star.fill", value: item.stargazersCount)
        forkRepositoryView.set(imageName: "arrow.merge", value: item.forksCount)
        issuesRepositoryView.set(imageName: "exclamationmark.circle", value: item.openIssuesCount)

        avatarImageView.fetchImage(stringUrl: item.avatarUrl)
        separatorView.isHidden = removeSeparator
        accessibilityIdentifier = "repositoryCollectionViewCell\(index)"
    }
}
