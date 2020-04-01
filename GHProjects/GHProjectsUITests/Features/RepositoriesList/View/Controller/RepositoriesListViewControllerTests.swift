//
//  RepositoriesListViewControllerTests.swift
//  GHProjectsUITests
//
//  Created by Jonathan Bijos on 25/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects

// swiftlint:disable all

final class RepositoriesListViewControllerTests: KIFTestCase {
    fileprivate var dependencyContainer: FakeDependencyContainer!
    var navigationController: UINavigationController!
    var coordinator: RepositoriesListCoordinator!

    // MARK: - Mocks
    lazy var owner = Owner(id: 0, login: "pebmed", avatarUrl: nil)
    lazy var repository1 = Repository(id: 0, name: "John Sundell", fullName: "John MiddleName Sundell", description: "Swift by Sundell",
                                      owner: owner, stargazersCount: 2500, forksCount: 10, openIssuesCount: 25)
    lazy var repository2 = Repository(id: 1, name: "Guilherme Rambo", fullName: "Guilherme MiddleName Rambo", description: "Stacktrace",
                                      owner: owner, stargazersCount: 50000, forksCount: 24, openIssuesCount: 0)

    var user1 = User(id: 0, login: "userEmail@gmail.com", avatarUrl: nil, company: "Apple", name: "John Smith", location: "California",
                    bio: "iOS Developer", publicRepos: 5, publicGists: 10, htmlUrl: "google.com", following: 250,
                    followers: 5600, createdAt: Date())
    lazy var base1 = Base(label: "Base 1", ref: "reference 1", repo: repository1)
    lazy var pullRequest1 = PullRequest(id: 0, number: 5, title: "Cant find enum", body: "Problem!!!", createdAt: Date(),
                                        user: user1, base: base1)
    lazy var pullRequest2 = PullRequest(id: 1, number: 15, title: "Unable to compile app", body: "I need somebody help",
                                        createdAt: Date(), user: user1, base: base1)

    override func beforeEach() {
        dependencyContainer = FakeDependencyContainer()
    }

    private func startCoordinator() {
        navigationController = UINavigationController()
        UIApplication.shared.keyWindowInConnectedScenes?.rootViewController = navigationController
        coordinator = RepositoriesListCoordinator(navigationController: navigationController, factory: dependencyContainer)
        coordinator.start()
    }

    private func makeUserDetailService() -> UserDetailService {
        let service = FakeUserDetailService(responseType: .sucess)
        service.user = User(id: 12848020, login: "luizhammeli", avatarUrl: "https://avatars0.githubusercontent.com/u/12848020?v=4", company: "PEBMED", name: "Luiz Hammerli", location: "Rio de Janeiro, RJ", bio: "iOS Developer", publicRepos: 16, publicGists: 0, htmlUrl: "https://github.com/luizhammeli", following: 3, followers: 10, createdAt: Date())

        return service
    }

    private func makeRepositoryServiceWithTwoRepos() -> RepositoryService {
        let service = FakeRespositoryService(responseType: .sucess)

        var repositories: [Repository] = []
        repositories.append(repository1)
        repositories.append(repository2)

        service.searchRepositories = SearchRepositories(items: repositories)
        service.hasNext = false

        return service
    }

    private func makePullRequestServiceWithTwoPRs() -> PullRequestService {
        let service = FakePullRequestService(responseType: .sucess)

        var pullRequests: [PullRequest] = []
        pullRequests.append(pullRequest1)
        pullRequests.append(pullRequest2)
        service.pullRequest = pullRequests
        service.hasNext = false

        return service
    }

    private func makePullRequestDetailService() -> PullRequestDetailsService {
        let service = FakePullRequestDetailService(responseType: .sucess)
        let head = Base(label: "roshal:master", ref: "master", repo: repository2)
        let base =  Base(label: "airbnb:master", ref: "master", repo: repository1)

        service.pullRequestDetail = PullRequestDetail(id: 106174713,
                                             number: 8,
                                             changedFiles: 10,
                                             additions: 10,
                                             deletions: 8,
                                             title:  "Cant find enum",
                                             state: "open",
                                             body: "I need somebody help",
                                             createdAt: Date(),
                                             base: base, head: head)
        return service
    }

    func testViewControllerShown() {
        dependencyContainer.repositoryService = makeRepositoryServiceWithTwoRepos()

        startCoordinator()
        tester.waitForView(withAccessibilityIdentifier: "repositoriesListViewControllerView")
    }

    func testNumberOfItemsInCollectionView() {
        let service = FakeRespositoryService(responseType: .sucess)

        var repositories: [Repository] = []
        repositories.append(repository1)
        repositories.append(repository2)

        service.searchRepositories = SearchRepositories(items: repositories)
        service.hasNext = false

        dependencyContainer.repositoryService = service

        startCoordinator()
        let collectionView = tester.waitForView(withAccessibilityIdentifier: "repositoriesListViewControllerCollectionView") as! UICollectionView
        let numberOfItemsInFirstSection = collectionView.numberOfItems(inSection: 0)

        XCTAssert(repositories.count == numberOfItemsInFirstSection, "Number of items in service do not match in collectionview")
    }

    func testFirstCellTap() {
        dependencyContainer.repositoryService = makeRepositoryServiceWithTwoRepos()
        dependencyContainer.pullRequestService = makePullRequestServiceWithTwoPRs()
        dependencyContainer.pullRequestDetailService = makePullRequestDetailService()
        dependencyContainer.userDetailService = makeUserDetailService()

        startCoordinator()
        tester.tapView(withAccessibilityIdentifier: "repositoryCollectionViewCell0")
        tester.waitForView(withAccessibilityIdentifier: "pullRequestListViewControllerView")
        tester.tapView(withAccessibilityIdentifier: "pullRequestCollectionViewCell0")
        tester.tapView(withAccessibilityIdentifier: "secondContainerID")
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
        let defaultPullRequestViewModel = DefaultPullRequestViewModel(ownerName: viewModelItem.login,
                                                                      repoName: viewModelItem.name,
                                                                      service: pullRequestService)
        return PullRequestListViewController(coordinator: coordinator, viewModel: defaultPullRequestViewModel)
    }
}

extension FakeDependencyContainer: PullRequestDetailFactory {
    func makePullRequestDetailViewController(coordinator: PullRequestDetailCoordinatorProtocol,
                                             viewModelItem: PullRequestViewModelItem,
                                             ownerName: String,
                                             repoName: String) -> PullRequestDetailViewController {
        let pullRequestDetailViewModel = DefautPullRequestDetailsViewModel(login: ownerName,
                                                                           repoName: repoName,
                                                                           pullRequestNumber: viewModelItem.number,
                                                                           service: pullRequestDetailService)

        return PullRequestDetailViewController(coordinator: coordinator, viewModel: pullRequestDetailViewModel)
    }
}

extension FakeDependencyContainer: UserDetailFactory {
    func makeUserDetailViewController(userName: String, coordinator: UserDetailCoordinator) -> UserDetailViewController {
        let viewModel = DefaultUserDetailViewModel(userName: userName, service: userDetailService)
        return UserDetailViewController(viewModel: viewModel, coordinator: coordinator)
    }
}

