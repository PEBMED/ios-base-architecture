//
//  DependencyContainer+RepositoryFactory.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

extension DependencyContainer: RepositoryFactory {
    func makeRepositoriesListViewController(coordinator: RepositoriesListCoordinatorProtocol) -> RepositoriesListViewController {
        let service = DefaultRepositoryService()
        let viewModel = DefaultRepositoryViewModel(service: service)
        let controller = RepositoriesListViewController(coordinator: coordinator, viewModel: viewModel)
        controller.title = "Repositories"
        controller.tabBarItem.image = SFSymbols.folder
        return controller
    }
}
