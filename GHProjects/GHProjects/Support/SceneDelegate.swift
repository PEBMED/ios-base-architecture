//
//  SceneDelegate.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder {
    // MARK: - Properties
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?
}

// MARK: - UIWindowSceneDelegate
extension SceneDelegate: UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard !isRunningUITests, !isRunningUITests else {
            let window = configuredWindow(scene: scene)
            let viewController = UIViewController()
            viewController.view.backgroundColor = .white
            window.rootViewController = viewController

            window.makeKeyAndVisible()
            return
        }

        let window = configuredWindow(scene: scene)

        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.applicationCoordinator = applicationCoordinator
        applicationCoordinator.start()

        window.makeKeyAndVisible()
    }
}

// MARK: - Private
private extension SceneDelegate {
    func configuredWindow(scene: UIScene) -> UIWindow {
        guard let scene = (scene as? UIWindowScene) else {
            fatalError("No UIWindowScene configured")
        }
        let window = UIWindow(frame: scene.coordinateSpace.bounds)
        window.windowScene = scene
        self.window = window
        return window
    }
}

// MARK: - Testing
private extension SceneDelegate {
    var isRunningUnitTests: Bool {
        return NSClassFromString("XCTest") != nil
    }

    var isRunningUITests: Bool {
        return NSClassFromString("XCUIApplication") != nil || NSClassFromString("KIFTestCase") != nil
    }
}
