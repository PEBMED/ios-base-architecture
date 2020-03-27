//
//  GHAvatarImageView.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class GHAvatarImageView: UIImageView {
    private let size: CGSize
    private let imageDownloader: ImageDownloader

    override var intrinsicContentSize: CGSize {
        return size
    }

    init(size: CGSize, imageDownloader: ImageDownloader = DefaultImageDownloader()) {
        self.size = size
        self.imageDownloader = imageDownloader
        super.init(frame: .zero)
        setupLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout() {
        layer.cornerRadius = size.height / 2
        contentMode = .scaleToFill
        clipsToBounds = true
        image = #imageLiteral(resourceName: "avatar-placeholder-dark")
    }

    func fetchImage(stringUrl: String) {
        imageDownloader.download(stringURL: stringUrl) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure:
                break
            }
        }
    }
}
