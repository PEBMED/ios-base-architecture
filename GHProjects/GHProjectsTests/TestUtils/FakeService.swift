//
//  FakeService.swift
//  GHProjectsTests
//
//  Created by Jonathan Bijos on 27/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

class FakeService {
    let responseType: FakeResponseType

    init(responseType: FakeResponseType) {
        self.responseType = responseType
    }
}
