//
//  DefaultUserDetailViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class DefaultUserDetailViewModel: UserDetailViewModel {
    let userName: String
    let service: UserDetailService
    var userDetailViewModelItem: UserDetailViewModelItem?

    required init(userName: String, service: UserDetailService) {
        self.service = service
        self.userName = userName
    }

    func fetchUserDetail(_ completion: @escaping (UserDetailViewModelItem?, String?) -> Void) {
        service.fetchUserDetailData(userName: userName) { result in
            switch result {
            case .success(let user):
                self.userDetailViewModelItem = self.setViewModelItem(user: user)
                completion(self.getUserViewModelItem(), nil)
            case .failure(let error):
                completion(nil, error.rawValue)
            }
        }
    }

    func getUserViewModelItem() -> UserDetailViewModelItem? {
        return userDetailViewModelItem
    }

    func setViewModelItem(user: User) -> UserDetailViewModelItem {
        return UserDetailViewModelItem(login: user.login,
                                       name: user.name ?? "",
                                       location: user.location ?? "No Location Available",
                                       company: user.company ?? "Not Available",
                                       bio: user.bio ?? "No Bio Info Available",
                                       avatarUrl: user.avatarUrl ?? "",
                                       profileUrl: user.htmlUrl,
                                       followersAtributtedText: setupFollowersAtributtedText(following: user.following ?? 0,
                                                                                             followers: user.followers ?? 0))
    }

    func setupFollowersAtributtedText(following: Int, followers: Int) -> NSMutableAttributedString {
        let atributtedString = NSMutableAttributedString(
            string: "\(followers) ",
            attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13.5)])

        atributtedString.append(NSAttributedString(string: "followers",
                                                   attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                                                                NSAttributedString.Key.foregroundColor: UIColor.darkGray]))

        atributtedString.append(NSAttributedString(string: " • ",
                                                   attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                                                                NSAttributedString.Key.foregroundColor: UIColor.darkGray]))

        atributtedString.append(NSAttributedString(string: "\(following) ",
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))

        atributtedString.append(NSAttributedString(string: "following",
                                                   attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.5),
                                                                NSAttributedString.Key.foregroundColor: UIColor.darkGray]))

        return atributtedString
    }
}
