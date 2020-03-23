//
//  TabbarCoordinator.swift
//  GHProjectsUITests
//
//  Created by Jonathan Bijos on 23/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects

// swiftlint:disable all

final class TabBarControllerTests: KIFTestCase {
    var factory: TabbarCoordinator.Factory!
    var coordinator: TabbarCoordinator!

    override func beforeEach() {
        factory = FakeDependencyContainer()
        coordinator = TabbarCoordinator(window: UIApplication.shared.keyWindowInConnectedScenes!, factory: factory)
        coordinator.start()
    }

    // MARK: - ViewController -
    func testElements() {
        tester.waitForView(withAccessibilityIdentifier: "ghTabBarControllerView")
    }
}

final fileprivate class FakeDependencyContainer {
    var repositoryService: RepositoryService

    init(repositoryService: RepositoryService = FakeRespositoryService(responseType: .sucess)) {
        self.repositoryService = repositoryService
    }
}


extension FakeDependencyContainer: RepositoryFactory {
    func makeRepositoriesListViewController(coordinator: RepositoriesListCoordinatorProtocol) -> RepositoriesListViewController {
        let viewModel = DefaultRepositoryViewModel(service: repositoryService)
        let controller = RepositoriesListViewController(coordinator: coordinator, viewModel: viewModel)
        controller.title = "Repositories"
        controller.tabBarItem.image = SFSymbols.folder
        return controller
    }
}

extension FakeDependencyContainer: PullRequestListFactory {
    func makePullRequestListViewController(coordinator: PullRequestListCoordinatorProtocol,
                                           viewModelItem: RepositoryViewModelItem) -> PullRequestListViewController {
        let service = DefaultPullRequestService()
        let defaultPullRequestViewModel = DefaultPullRequestViewModel(ownerName: viewModelItem.login,
                                                                      repoName: viewModelItem.name,
                                                                      service: service)
        return PullRequestListViewController(coordinator: coordinator, viewModel: defaultPullRequestViewModel)
    }
}

extension FakeDependencyContainer: PullRequestDetailFactory {
    func makePullRequestDetailViewController(coordinator: PullRequestDetailCoordinatorProtocol,
                                             viewModelItem: PullRequestViewModelItem,
                                             ownerName: String,
                                             repoName: String) -> PullRequestDetailViewController {
        let service = DefaultPullRequestDetailsService()
        let pullRequestDetailViewModel = DefautPullRequestDetailsViewModel(login: ownerName,
                                                                           repoName: repoName,
                                                                           pullRequestNumber: viewModelItem.number,
                                                                           service: service)

        return PullRequestDetailViewController(coordinator: coordinator, viewModel: pullRequestDetailViewModel)
    }
}

extension FakeDependencyContainer: FavoritesFactory {
    func makeFavoritesViewController(coordinator: FavoritesCoordinatorProtocol) -> FavoritesViewController {
        let controller = FavoritesViewController()
        controller.title = "Favorites"
        controller.tabBarItem.image = SFSymbols.star
        return controller
    }
}

extension FakeDependencyContainer: UserDetailFactory {
    func makeUserDetailViewController(userName: String, coordinator: UserDetailCoordinator) -> UserDetailViewController {
        let service = DefaultUserDetailService()
        let viewModel = DefaultUserDetailViewModel(userName: userName, service: service)
        return UserDetailViewController(viewModel: viewModel, coordinator: coordinator)
    }
}
