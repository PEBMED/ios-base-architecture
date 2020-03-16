//
//  UserDetailCoordinator.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import SafariServices
import UIKit

protocol UserDetailCoordinatorProtocol: AnyObject {
    func goToProfile(stringUrl: String)
}

class UserDetailCoordinator: Coordinator {
    let factory: UserDetailFactory
    let userName: String
    var navigationController: UINavigationController

    init(userName: String, factory: UserDetailFactory, navigationController: UINavigationController) {
        self.factory = factory
        self.userName = userName
        self.navigationController = navigationController
    }

    func start() {
        let userDetailNavigationController = UINavigationController()
        let controller = factory.makeUserDetailViewController(userName: userName, coordinator: self)

        userDetailNavigationController.viewControllers = [controller]

        self.navigationController.present(userDetailNavigationController, animated: true, completion: nil)
        self.navigationController = userDetailNavigationController
    }
}

extension UserDetailCoordinator: UserDetailCoordinatorProtocol {
    func goToProfile(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        let safariController = SFSafariViewController(url: url)
        navigationController.pushViewController(safariController, animated: true)
    }
}
