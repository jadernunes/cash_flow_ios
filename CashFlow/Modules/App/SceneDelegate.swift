//
//  SceneDelegate.swift
//  CashFlow
//
//  Created by Jader Nunes on 04/05/22.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Attributes

    var window: UIWindow?

    // MARK: - Life cycle

    convenience init(window: UIWindow) {
        self.init()
        self.window = window
    }

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(frame: windowScene.screen.bounds)
        window.windowScene = windowScene

        self.window = window
    }
}
