//
//  MainFabric.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import UIKit

class MainFabric {
        
    func makeMainScreen(location: Location?) -> (UIViewController, MainScreenViewOutput) {
        let view = MainScreenView()
        let model = MainScreenViewModel(view: view, location: location)
        view.model = model
        return (view, model)
    }
    
    func makeLocationSelectorScreen() ->  (UIViewController, LocationSelectorViewOutput) {
        let view = LocationSelectorView.create()
        let model = LocationSelectorViewModel()
        view.model = model
        return (view, model)
    }
}
