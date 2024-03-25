//
//  SceneDelegate.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator : MainCoordinator?
    var locationManager = LocationService.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.appCoordinator = MainCoordinator(window, fabric: MainFabric())
        appCoordinator?.start()

        self.window = window
        
        locationManager.getLocation()
    }

}

