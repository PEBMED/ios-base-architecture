//
//  UserDetailView.swift
//  ios-base-architecture
//
//  Created by Luiz on 15/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class UserDetailView: UIView {
    let profileImageView: GHAvatarImageView = {
        let imageView = GHAvatarImageView(size: CGSize(width: 70, height: 70))
        imageView.image = #imageLiteral(resourceName: "avatar-placeholder-dark")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        return imageView
    }()

    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        return label
    }()

    let userLoginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .thin)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()

    let bioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()

    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show All Github Profile", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 0.7
        button.setTitleColor(.darkGray, for: .normal)
        return button
    }()

    let companyInfoView = GHUserInfoView(color: .darkGray, icon: SFSymbols.persons ?? UIImage())
    let locationInfoView = GHUserInfoView(color: .darkGray, icon: SFSymbols.location ?? UIImage())
    let emailInfoView = GHUserInfoView(color: .darkGray,
                                       icon: SFSymbols.mail ?? UIImage(),
                                       labelColor: .systemBlue)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews(viewModelItem: UserDetailViewModelItem) {
        setupHeader()
        setupUserProfile()
        set(viewModelItem: viewModelItem)
    }

    func setupHeader() {
        addSubview(profileImageView)
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor,
                                leading: leadingAnchor,
                                padding: UIEdgeInsets(top: 24, left: 18, bottom: 0, right: 0))
        profileImageView.anchor(height: 72, width: 72)

        let labelStackView = UIStackView(arrangedSubviews: [userNameLabel, userLoginLabel, UIView()])
        labelStackView.axis = .vertical

        addSubview(labelStackView)

        labelStackView.anchor(top: profileImageView.topAnchor,
                              leading: profileImageView.trailingAnchor,
                              trailing: trailingAnchor,
                              padding: UIEdgeInsets(top: 2, left: 24, bottom: 0, right: 10))
    }

    func setupUserProfile() {
        let stackView = UIStackView(arrangedSubviews: [bioLabel, companyInfoView, locationInfoView, emailInfoView, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 10

        addSubviews(stackView, profileButton)

        stackView.anchor(top: profileImageView.bottomAnchor,
                         leading: profileImageView.leadingAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 10))

        profileButton.anchor(top: stackView.bottomAnchor,
                             leading: leadingAnchor,
                             trailing: trailingAnchor,
                             padding: UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20))
        profileButton.anchor(height: 42)
    }

    func set(viewModelItem: UserDetailViewModelItem) {
        profileImageView.fetchImage(stringUrl: viewModelItem.avatarUrl)
        userNameLabel.text = viewModelItem.name
        userLoginLabel.text = viewModelItem.login
        bioLabel.text = viewModelItem.bio
        companyInfoView.nameLabel.text = viewModelItem.company
        locationInfoView.nameLabel.text = viewModelItem.location
        emailInfoView.nameLabel.text = "\(viewModelItem.login)@gmail.com"
    }
}
