//
//  TabBarControllerTests.swift
//  GHProjectsUITests
//
//  Created by Jonathan Bijos on 23/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects

// swiftlint:disable all

final class TabBarControllerTests: KIFTestCase {
    fileprivate var dependencyContainer: FakeDependencyContainer!
    var coordinator: TabbarCoordinator!

    // MARK: - Mocks
    lazy var owner = Owner(id: 0, login: "pebmed", avatarUrl: nil)
    lazy var repository1 = Repository(id: 0, name: "John Sundell", fullName: "John MiddleName Sundell", description: "Swift by Sundell",
                                      owner: owner, stargazersCount: 2500, forksCount: 10, openIssuesCount: 25)
    lazy var repository2 = Repository(id: 1, name: "Guilherme Rambo", fullName: "Guilherme MiddleName Rambo", description: "Stacktrace",
                                      owner: owner, stargazersCount: 50000, forksCount: 24, openIssuesCount: 0)

    override func beforeEach() {
        dependencyContainer = FakeDependencyContainer()
    }

    func startCoordinator() {
        coordinator = TabbarCoordinator(window: UIApplication.shared.keyWindowInConnectedScenes!, factory: dependencyContainer)
        coordinator.start()
    }

    func makeRepositoryServiceWithTwoRepos() -> RepositoryService {
        let service = FakeRespositoryService(responseType: .sucess)

        var repositories: [Repository] = []
        repositories.append(repository1)
        repositories.append(repository2)

        service.searchRepositories = SearchRepositories(items: repositories)
        service.hasNext = false

        return service
    }

    func testTabbarController() {
        dependencyContainer.repositoryService = makeRepositoryServiceWithTwoRepos()

        startCoordinator()
        tester.waitForView(withAccessibilityIdentifier: "ghTabBarControllerView")
    }

    func testDefaultSelectedTabbarItem() {
        dependencyContainer.repositoryService = makeRepositoryServiceWithTwoRepos()

        startCoordinator()
        tester.waitForView(withAccessibilityIdentifier: "repositoriesListViewControllerView")
    }

    func testSecondTabbarItemTap() {
        dependencyContainer.repositoryService = makeRepositoryServiceWithTwoRepos()

        startCoordinator()
        tester.tapView(withAccessibilityIdentifier: "favoritesTabBarItem")
        tester.waitForView(withAccessibilityIdentifier: "favoritesViewControllerView")
    }
}

final fileprivate class FakeDependencyContainer {
    var repositoryService: RepositoryService!
    var pullRequestService: PullRequestService!
    var pullRequestDetailService: PullRequestDetailsService!
    var userDetailService: UserDetailService!
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
        controller.tabBarItem.accessibilityIdentifier = "favoritesTabBarItem"
        return controller
    }
}

extension FakeDependencyContainer: UserDetailFactory {
    func makeUserDetailViewController(userName: String, coordinator: UserDetailCoordinator) -> UserDetailViewController {
        let viewModel = DefaultUserDetailViewModel(userName: userName, service: userDetailService)
        return UserDetailViewController(viewModel: viewModel, coordinator: coordinator)
    }
}
