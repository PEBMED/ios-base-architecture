//
//  ApplicationCoordinator.swift
//  ios-base-architecture
//
//  Created by Jonathan Bijos on 13/03/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    // MARK: - Properties
    private let window: UIWindow
    private let coordinator: Coordinator

    // MARK: - Init
    init(window: UIWindow, coordinator: Coordinator? = nil) {
        self.window = window
        let dependencyContainer = DependencyContainer()
        self.coordinator = coordinator ?? TabbarCoordinator(window: window, factory: dependencyContainer)
    }

    // MARK: - Coordinator
    func start() {
        coordinator.start()
    }
}
