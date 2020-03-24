//
//  FakeUserDetailService.swift
//  GHProjectsUITests
//
//  Created by Jonathan Bijos on 23/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

@testable import GHProjects

final class FakeUserDetailService: FakeService, UserDetailService {
    var user: User!
    var error: GHError!

    func fetchUserDetailData(userName: String, completionHandler: @escaping (Result<User, GHError>) -> Void) {
        switch responseType {
        case .sucess:
            completionHandler(.success(user))
        case .failure:
            completionHandler(.failure(error))
        }
    }
}
