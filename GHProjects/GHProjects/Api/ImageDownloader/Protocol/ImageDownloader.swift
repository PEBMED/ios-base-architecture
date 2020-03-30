//
//  ImageDownloader.swift
//  GHProjects
//
//  Created by Jonathan Bijos on 27/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

protocol ImageDownloader {
    func download(stringURL: String, completion: @escaping (Result<UIImage, GHImageError>) -> Void)
}
