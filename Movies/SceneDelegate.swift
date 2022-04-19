//
//  SceneDelegate.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let rootBuilder = MoviesViewControllerBuilder()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = rootBuilder.build()
        window?.makeKeyAndVisible()
    }

}
