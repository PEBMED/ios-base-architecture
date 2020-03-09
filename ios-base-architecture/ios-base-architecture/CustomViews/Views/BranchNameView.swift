//
//  BranchNameView.swift
//  ios-base-architecture
//
//  Created by Luiz on 26/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class BranchNameView: UIView {
    let branchNameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemBlue
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 12, weight: .light)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.08)
        layer.cornerRadius = 3
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubviews(branchNameLabel)
        branchNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6))
    }

    func set(branchName: String) {
        self.branchNameLabel.text = branchName
    }
}
