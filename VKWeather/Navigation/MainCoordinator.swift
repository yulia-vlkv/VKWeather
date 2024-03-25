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
    private var navigationController: UINavigationController?

    init(_ window: UIWindow, fabric: MainFabric) {
        self.fabric = fabric
        self.window = window
    }
    
    func start() {
        showMainScreen()
    }
    
    // MARK: - Показать главный экран
    private func showMainScreen(location: Location? = nil) {
        let (controller, screen) = fabric.makeMainScreen(location: location)
        
        screen.onOpenLocationSelection = { [weak self] in
            self?.showManualLocationScreen()
        }
        
        let navigationController = fabric.makeNavigationController(rootViewController: controller)
        
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        UserDefaults.standard.set(true, forKey: "LocationSelected")
    }
    
    // MARK: - Показать окно выбора локации
    private func showManualLocationScreen() {
        
        let (controller, model) = fabric.makeLocationSelectorScreen()

        model.onClose = { [weak self] in
            controller.dismiss(animated: false)
        }
        
        model.onSuccess = { [weak self] location in
            self?.showMainScreen(location: location)
        }
        
        window.rootViewController?.present(controller, animated: true)
    }
    
}

