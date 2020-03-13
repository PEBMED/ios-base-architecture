//
//  FavoritesViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 03/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    let emptyView = GHEmptyView(text: "Sorry! 😅\nWe are working to release this feature as soon as possible.\nPlease stay tuned!")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
    }

    func setupViews() {
        view.addSubview(emptyView)
        emptyView.fillSuperview()
    }
}
