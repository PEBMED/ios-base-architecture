//
//  UserDetailViewModel.swift
//  ios-base-architecture
//
//  Created by Luiz on 14/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

protocol UserDetailViewModel {
    init(userName: String, service: UserDetailService)
    func fetchUserDetail(_ completion: @escaping (Bool, String?) -> Void)
    func getUserViewModelItem() -> UserProfessionalDataViewModelItem?
}
