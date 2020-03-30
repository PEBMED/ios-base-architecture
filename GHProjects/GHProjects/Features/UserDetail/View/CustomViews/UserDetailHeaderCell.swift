//
//  UserDetailHeaderCell.swift
//  ios-base-architecture
//
//  Created by Luiz on 19/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class UserDetailHeaderCell: UICollectionViewCell {
    // MARK: - Views
    private let profileImageView: GHAvatarImageView = {
        let imageView = GHAvatarImageView(size: CGSize(width: 70, height: 70))
        imageView.image = #imageLiteral(resourceName: "avatar-placeholder-dark")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let userLoginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .thin)
        return label
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()

    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show All Github Profile", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.8).cgColor
        button.layer.borderWidth = 0.7
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()

    private let companyInfoView = GHUserInfoView(color: .gray, icon: SFSymbols.persons ?? UIImage())
    private let locationInfoView = GHUserInfoView(color: .gray, icon: SFSymbols.location ?? UIImage())

    private let emailInfoView = GHUserInfoView(color: .gray, icon: SFSymbols.mail ?? UIImage(), bold: true)
    private let followInfoView = GHUserInfoView(color: .gray, icon: SFSymbols.mail ?? UIImage(), bold: true)
    private let personInfoView = GHUserInfoView(color: .gray, icon: SFSymbols.person ?? UIImage())

    private let separator = CellSeparatorView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    func setupViews(viewModelItem: UserProfessionalDataViewModelItem) {
        setupHeader()
        setupUserProfile()
        set(viewModelItem: viewModelItem)
    }

    // MARK: - Private functions
    private func set(viewModelItem: UserProfessionalDataViewModelItem) {
        profileImageView.fetchImage(stringUrl: viewModelItem.avatarUrl)
        userNameLabel.text = viewModelItem.name
        userLoginLabel.text = viewModelItem.login
        bioLabel.text = viewModelItem.bio
        companyInfoView.nameLabel.text = viewModelItem.company
        locationInfoView.nameLabel.text = viewModelItem.location
        emailInfoView.nameLabel.text = "\(viewModelItem.login)@gmail.com"
        personInfoView.nameLabel.attributedText = viewModelItem.followersAtributtedText
    }

    private func setupHeader() {
        addSubview(profileImageView)
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                leading: leadingAnchor,
                                padding: UIEdgeInsets(top: 24, left: 18, bottom: 0, right: 0))
        profileImageView.anchor(height: 72, width: 72)

        let labelStackView = UIStackView(arrangedSubviews: [userNameLabel, userLoginLabel, UIView()])
        labelStackView.axis = .vertical

        addSubview(labelStackView)

        labelStackView.anchor(top: nil,
                              leading: profileImageView.trailingAnchor,
                              trailing: trailingAnchor,
                              padding: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 10))
        labelStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
    }

    private func setupUserProfile() {
        let stackView = UIStackView(arrangedSubviews: [bioLabel,
                                                       UIView(),
                                                       companyInfoView,
                                                       locationInfoView,
                                                       emailInfoView,
                                                       personInfoView,
                                                       UIView()])
        stackView.axis = .vertical
        stackView.spacing = 9

        addSubviews(stackView, separator)

        stackView.anchor(top: profileImageView.bottomAnchor,
                         leading: profileImageView.leadingAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 10))

        separator.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        separator.anchor(height: 0.5)
    }
}
