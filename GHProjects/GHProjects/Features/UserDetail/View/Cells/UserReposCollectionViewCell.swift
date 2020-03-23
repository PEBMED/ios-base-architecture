//
//  UserReposCollectionViewCell.swift
//  ios-base-architecture
//
//  Created by Luiz on 19/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class UserReposCollectionViewCell: UICollectionViewCell {
    let topSeparatorView = CellSeparatorView()
    let bottomSeparatorView = CellSeparatorView()

    let pinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .darkGray
        imageView.image = UIImage(systemName: "pin")
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.transform = CGAffineTransform(rotationAngle: -0.8)
        return imageView
    }()

    let pinLabel: UILabel = {
        let label = UILabel()
        label.text = "Pinned"
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()

    let padding: CGFloat = 18

    var collectionView: UserRepoCollectionViewController?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        backgroundColor = .systemBackground

        addSubviews(topSeparatorView, bottomSeparatorView)

        topSeparatorView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor)
        topSeparatorView.anchor(height: 0.4)

        bottomSeparatorView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomSeparatorView.anchor(height: 0.6)

        setupTitleStackView()
    }

    func setupTitleStackView() {
        let titleStackView = UIStackView(arrangedSubviews: [pinImageView, pinLabel])
        titleStackView.spacing = 8
        titleStackView.alignment = .center

        addSubview(titleStackView)

        titleStackView.anchor(top: topAnchor,
                              leading: leadingAnchor,
                              bottom: nil,
                              trailing: trailingAnchor,
                              padding: UIEdgeInsets(top: padding, left: padding, bottom: 0, right: padding))
    }

    func setupCollectionView(viewModel: UserDetailViewModel) {
        collectionView = UserRepoCollectionViewController(viewModel: viewModel)

        guard let collectionView = collectionView?.view else { return }
        addSubview(collectionView)

        collectionView.anchor(top: pinImageView.bottomAnchor,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              padding: UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0))
    }
}
