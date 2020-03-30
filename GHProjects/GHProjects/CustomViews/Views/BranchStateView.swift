//
//  BranchStateView.swift
//  ios-base-architecture
//
//  Created by Luiz on 26/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class BranchStateView: UIView {
    private let label: UILabel = {
        let view = UILabel()
        view.text = "Open"
        view.textColor = #colorLiteral(red: 0.2941176471, green: 0.5411764706, blue: 0.2980392157, alpha: 1)
        view.font = .systemFont(ofSize: 11, weight: .semibold)
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = SFSymbols.branch
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = #colorLiteral(red: 0.2941176471, green: 0.5411764706, blue: 0.2980392157, alpha: 1)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.9843137255, blue: 0.9529411765, alpha: 1)
        layer.cornerRadius = 3
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.spacing = 2
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        addSubview(stackView)

        stackView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
    }
}
