//
//  Enum.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import Foundation

enum GHError: String, Error {
    case invalidUsername = "This username created a invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection. "
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again."
    case titleError = "Bad Stuff Happend"
    case userExist = "This user has already been saved as Favorite. Try add another user. 😉"
}
