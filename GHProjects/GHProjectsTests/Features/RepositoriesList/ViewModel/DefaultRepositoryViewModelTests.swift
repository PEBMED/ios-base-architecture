//
//  DefaultRepositoryViewModelTests.swift
//  GHProjectsTests
//
//  Created by Jonathan Bijos on 27/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects
import XCTest

final class DefaultRepositoryViewModelTests: XCTestCase {
    var service: FakeRepositoryService!
    var sut: DefaultRepositoryViewModel!

    func testSuccess() {
        // Arrange
        service = FakeRepositoryService(responseType: .success)

        var repositories: [Repository] = []
        let owner1 = Owner(id: 0, login: "ownerLogin", avatarUrl: "http://www.google.com")
        let repository1 = Repository(id: 0, name: "First Repo", fullName: "First Repo Full Name", description: "Description example",
                                     owner: owner1, stargazersCount: 50, forksCount: 12, openIssuesCount: 100)
        let repository2 = Repository(id: 0, name: "Second Repo", fullName: "Second Repo Full name", description: "Description example 2",
                                     owner: owner1, stargazersCount: 90, forksCount: 5, openIssuesCount: 250)
        repositories.append(repository1)
        repositories.append(repository2)

        service.searchRepositories = SearchRepositories(items: repositories)
        service.hasNext = false

        sut = DefaultRepositoryViewModel(service: service)

        // Act
        sut.fetchRepositories { _, _ in }
        let firstIndexPath = IndexPath(item: 0, section: 0)
        let firstItem = sut.getRepositoryViewModelItem(with: firstIndexPath)

        // Assert
        XCTAssertTrue(firstItem.name == repository1.name)
        XCTAssertTrue(firstItem.description == repository1.description)
        XCTAssertTrue(firstItem.avatarUrl == repository1.owner.avatarUrl)
        XCTAssertTrue(firstItem.stargazersCount == repository1.stargazersCount)
        XCTAssertTrue(firstItem.forksCount == repository1.forksCount)
        XCTAssertTrue(firstItem.openIssuesCount == repository1.openIssuesCount)
        XCTAssertTrue(firstItem.ownerName == "• \(repository1.owner.login)")
        XCTAssertTrue(firstItem.login == repository1.owner.login)

        // Act
        let secondIndexPath = IndexPath(item: 1, section: 0)
        let secondItem = sut.getRepositoryViewModelItem(with: secondIndexPath)

        // Assert
        XCTAssertTrue(secondItem.name == repository2.name)
        XCTAssertTrue(secondItem.description == repository2.description)
        XCTAssertTrue(secondItem.avatarUrl == repository2.owner.avatarUrl)
        XCTAssertTrue(secondItem.stargazersCount == repository2.stargazersCount)
        XCTAssertTrue(secondItem.forksCount == repository2.forksCount)
        XCTAssertTrue(secondItem.openIssuesCount == repository2.openIssuesCount)
        XCTAssertTrue(secondItem.ownerName == "• \(repository2.owner.login)")
        XCTAssertTrue(secondItem.login == repository2.owner.login)

        // Act
        let totalNumberOfItems = sut.getRepositoryViewModelNumberOfItems()
        
        // Assert
        XCTAssertTrue(totalNumberOfItems == repositories.count)
    }
}

final class FakeRepositoryService: FakeService, RepositoryService {
    var searchRepositories: SearchRepositories!
    var error: GHError!
    var hasNext: Bool!

    func fetchRepositoriesData(completion: @escaping (Result<SearchRepositories, GHError>, Bool) -> Void) {
        switch responseType {
        case .success:
            completion(.success(searchRepositories), hasNext)
        case .failure:
            completion(.failure(error), hasNext)
        }
    }
}
