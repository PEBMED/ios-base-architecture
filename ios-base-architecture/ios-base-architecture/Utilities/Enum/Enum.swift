//
//  Enum.swift
//  ios-base-architecture
//
//  Created by Luiz on 22/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

enum GHError: String, Error {
    case invalidUsername = "This username created a invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection. "
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again."
    case titleError = "Bad Stuff Happend"
    case userExist = "This user has already been saved as Favorite. Try add another user. 😉"
    case genericError = "Error to processing your request. Please try again later."
}

enum SFSymbols {
    static let branch = UIImageView(image: UIImage(systemName: "arrow.branch"))
    static let folder = UIImage(systemName: "folder.fill")
    static let star = UIImage(systemName: "star.fill")
    static let arrow = UIImage(systemName: "arrow.right")
    static let chevron = UIImage(systemName: "chevron.right")
    static let calendar = UIImage(systemName: "calendar.circle")
}
