//
//  MainCoordinator.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    let window: UIWindow
    
    private let fabric: MainFabric

    init(_ window: UIWindow, fabric: MainFabric) {
        self.fabric = fabric
        self.window = window
    }
    
    func start() {
        showMainScreen()
    }
    
    private func showMainScreen(location: Location? = nil) {
        let (controller, screen) = fabric.makeMainScreen(location: location)
        
        screen.onOpenLocationSelection = { [weak self] in
            self?.showManualLocationScreen()
        }
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
        UserDefaults.standard.set(true, forKey: "LocationSelected")
    }
    
    
    private func showManualLocationScreen() {
        let (controller, model) = fabric.makeLocationSelectorScreen()
        
        model.onSuccess = { [weak self] location in
            self?.showMainScreen(location: location)
        }
    }
}
