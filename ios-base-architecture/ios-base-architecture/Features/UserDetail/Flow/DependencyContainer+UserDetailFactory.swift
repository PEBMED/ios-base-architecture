//
//  DependencyContainer+UserDetailFactory.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

extension DependencyContainer: UserDetailFactory {
    func makeUserDetailViewController(userName: String, coordinator: UserDetailCoordinator) -> UserDetailViewController {
        let service = DefaultUserDetailService()
        let viewModel = DefaultUserDetailViewModel(userName: userName, service: service)
        return UserDetailViewController(viewModel: viewModel, coordinator: coordinator)
    }
}
