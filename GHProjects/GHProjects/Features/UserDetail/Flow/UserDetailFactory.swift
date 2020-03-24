//
//  UserDetailFactory.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol UserDetailFactory: AnyObject {
    func makeUserDetailViewController(userName: String, coordinator: UserDetailCoordinator) -> UserDetailViewController
}
