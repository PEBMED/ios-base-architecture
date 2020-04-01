//
//  PullRequestCollectionViewCell.swift
//  ios-base-architecture
//
//  Created by Luiz on 24/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class PullRequestCollectionViewCell: UICollectionViewCell {
    private let userLoginLabel = GHTitleLabel()
    private let titleLabel = GHSubtitleLabel()
    private let dateLabel = GHSecondaryLabel()
    private let desciprionLabel = GHBodyLabel()

    private let separatorView = SeparatorView()
    private lazy var avatarImageView = GHAvatarImageView(size: avatarImageSize)

    private let avatarImageSize = CGSize(width: 58, height: 58)

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
        let labelHeight = label.height(width: UIScreen.main.bounds.width - 104)
        let height: CGFloat = 94 + (labelHeight)
        return CGSize(width: UIScreen.main.bounds.width - padding, height: height)
    }

    private func setupViews() {
        let titleStackView = createTitleStackView()

        self.addSubviews(avatarImageView, titleStackView, titleLabel, desciprionLabel, separatorView)

        avatarImageView.anchor(top: topAnchor, leading: leadingAnchor)
        avatarImageView.anchor(height: avatarImageSize.height, width: avatarImageSize.width)
        titleStackView.anchor(top: topAnchor,
                              leading: avatarImageView.trailingAnchor,
                              bottom: nil,
                              trailing: trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5))

        titleLabel.anchor(top: titleStackView.bottomAnchor,
                          leading: titleStackView.leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0))

        desciprionLabel.anchor(top: titleLabel.bottomAnchor,
                               leading: titleStackView.leadingAnchor,
                               bottom: nil,
                               trailing: trailingAnchor,
                               padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0))

        separatorView.anchor(top: desciprionLabel.bottomAnchor,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        separatorView.anchor(height: 1)
    }

    func createTitleStackView() -> UIStackView {
        let calendarImage = UIImageView()
        calendarImage.image = SFSymbols.calendar
        calendarImage.contentMode = .scaleAspectFit
        calendarImage.tintColor = #colorLiteral(red: 0, green: 0.6745098039, blue: 0.9294117647, alpha: 1)

        dateLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        calendarImage.widthAnchor.constraint(equalToConstant: 20).isActive = true

        let stackView = UIStackView(arrangedSubviews: [userLoginLabel, UIView(), calendarImage, dateLabel, UIView()])
        stackView.spacing = 6

        return stackView
    }

    func set(item: PullRequestViewModelItem, removeSeparator: Bool, index: Int) {
        userLoginLabel.text = item.login
        dateLabel.text = item.createdAt
        titleLabel.text = item.title
        desciprionLabel.text = item.body ?? ""

        avatarImageView.fetchImage(stringUrl: item.avatarUrl ?? "")
        separatorView.isHidden = removeSeparator
        accessibilityIdentifier = "pullRequestCollectionViewCell\(index)"
    }
}
