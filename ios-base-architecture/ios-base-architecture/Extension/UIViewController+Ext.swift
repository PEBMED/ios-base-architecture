//
//  UIViewController+Alert.swift
//  ios-base-architecture
//
//  Created by Luiz on 23/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

extension UIViewController {

    func showDefaultAlertOnMainThread(title: String, message: String) {
        DispatchQueue.main.async {            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)

            self.present(alertController, animated: true, completion: nil)
        }
    }

    func showLoader() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()

        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }

    func removeLoader() {
        DispatchQueue.main.async {
            self.view.subviews.forEach { view in
                if let loader = view as? UIActivityIndicatorView {
                    loader.removeFromSuperview()
                }
            }
        }
    }
}
