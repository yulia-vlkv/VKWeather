//
//  MainFabric.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import UIKit


class MainFabric {
    
    // Создаем NavigationController
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: rootViewController)
    }
    
    // Создаем главный экран
    func makeMainScreen(location: Location?) -> (UIViewController, MainScreenViewOutput) {
        let view = MainScreenView()
        let model = MainScreenViewModel(view: view, location: location)
        view.model = model
        LocationService.shared.locationDelegate = model
        return (view, model)
    }
    
    // Создаем экран выбора локации
    func makeLocationSelectorScreen() ->  (UIViewController, LocationSelectorViewOutput) {
        let view = LocationSelectorView.create()
        let model = LocationSelectorViewModel()
        view.model = model
        return (view, model)
    }
}

