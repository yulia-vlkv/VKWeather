//
//  MainScreenViewModel.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//


import Foundation
import UIKit
import CoreLocation


protocol MainScreenViewOutput: AnyObject {
    var onOpenLocationSelection: (() -> Void)? { get set }
}

enum MainScreenDataSourceSection {
    case current(MainScreenDataSourceItem)
    case daily([MainScreenDataSourceItem])
}

enum MainScreenDataSourceItem {
    case currentWeather(CurrentWeatherTableCellModel)
    case dailyWeather(DailyWeatherTableCellModel)
}

class MainScreenViewModel: MainScreenViewOutput {
    
    private let userDefaults = UserDefaults.standard
    private let key = "savedWeather"
    
    public var onOpenLocationSelection: (() -> Void)?
    
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    
    private weak var view: MainScreenView!
    
    private var location: Location {
        if let savedLocation = userDefaults.object(forKey: "selectedLocation") {
            do {
                let location = try JSONDecoder().decode(Location.self, from: savedLocation as! Data)
                return location
            } catch {
                print("Unable to decode weather (\(error))")
            }
        } else {
            return staticLocation ?? locationService.currentLocation ?? Location(city: "000", country: "000", longitude: "0000", latitude: "0000")
        }
        return Location(city: "000", country: "000", longitude: "0000", latitude: "0000")
    }
    
    private var staticLocation: Location?
    
    init(view: MainScreenView, location: Location?) {
        self.view = view
        self.staticLocation = location
    }
    
    private let currentDate = Date()
    
    var sections: [MainScreenDataSourceSection] = [] {
        didSet {
            view?.configure(with: self)
        }
    }
    
    private var fetchResults: WeatherModel? {
        didSet {
            if let fetchResults = fetchResults {
                sections = mapToViewModel(fetchResults: fetchResults)
            } else {
                sections = []
            }
        }
    }
    
    var city: String {
        return "\(location.city), \(location.country)"
    }
    
    public func showLocationSelection(){
        onOpenLocationSelection?()
    }
    
    func onViewDidLoad() {
        configureDataFromCache()
        fetchData()
        
    }
    
    private func configureDataFromCache() {
        if let savedWeather = userDefaults.object(forKey: key) {
            do {
                let savedWeather = try JSONDecoder().decode(WeatherModel.self, from: savedWeather as! Data)
                self.sections = self.mapToViewModel(fetchResults: savedWeather)
                print(savedWeather)
            } catch {
                print("Unable to decode weather (\(error))")
            }
        }
    }
    
    
    private func fetchData() {
        let urlString = forecastService.getURLString(latitude: location.latitude, longitude: location.longitude)
        forecastService.performRequest(with: urlString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    debugPrint(weather)
                    self?.mapToViewModel(fetchResults: weather)
                    self?.saveDataToCache(fetchResults: weather)
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    private func saveDataToCache(fetchResults: WeatherModel) {
        do {
            let data = try JSONEncoder().encode(fetchResults)
            userDefaults.set(data, forKey: key)
        } catch {
            print("Unable to encode weather (\(error))")
        }
    }
    
    private func mapToViewModel(fetchResults: WeatherModel) -> [MainScreenDataSourceSection] {
        var resultSections: [MainScreenDataSourceSection] = []
        
        resultSections.append(
            .current(
                .currentWeather(CurrentWeatherTableCellModel(
                    with: fetchResults.currentWeather,
                    currentDate: currentDate)
                )
            )
        )
        
        resultSections.append(
            .daily(
                fetchResults.dailyWeather.map { model in
                    MainScreenDataSourceItem.dailyWeather(
                        DailyWeatherTableCellModel(
                            with: model
                        )
                    )}
            )
        )
        
        return resultSections
    }
}
