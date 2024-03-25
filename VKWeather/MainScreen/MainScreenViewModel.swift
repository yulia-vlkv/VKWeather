//
//  MainScreenViewModel.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//


import Foundation
import UIKit
import CoreLocation


// Для перехода на экран выбора локации
protocol MainScreenViewOutput: AnyObject {
    var onOpenLocationSelection: (() -> Void)? { get set }
}

// Две секции основного экрана
enum MainScreenDataSourceSection {
    case current(MainScreenDataSourceItem)
    case daily([MainScreenDataSourceItem])
}

// Два типа погоды, отражаемые на основном экране
enum MainScreenDataSourceItem {
    case currentWeather(CurrentWeatherTableCellModel)
    case dailyWeather(DailyWeatherTableCellModel)
}


// MARK: - Вьюмодель основного экрана
class MainScreenViewModel: MainScreenViewOutput {
    
    private let userDefaults = UserDefaults.standard
    private let forecastService = ForecastService()
    private let locationService = LocationService.shared
    private let currentDate = Date()
    
    private weak var view: MainScreenView!
    private var staticLocation: Location?
    
    public var onOpenLocationSelection: (() -> Void)?
    
    init(view: MainScreenView, location: Location?) {
        self.view = view
        self.staticLocation = location
    }
    
    // MARK: - Вычисляемые переменные
    // Определяем текущую локацию
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
        return Location(city: "Город", country: "Страна", longitude: "0000", latitude: "0000")
    }
    
    // Конфигурируем секции
    var sections: [MainScreenDataSourceSection] = [] {
        didSet {
            view?.configure(with: self)
        }
    }
    
    // Соотносим полученные данные с вьюмоделями
    private var fetchResults: WeatherModel? {
        didSet {
            if let fetchResults = fetchResults {
                sections = mapToViewModel(fetchResults: fetchResults)
            } else {
                sections = []
            }
        }
    }
    
    // Определяем заголовок для экрана
    var city: String {
        return "\(location.city), \(location.country)"
    }
    
    // MARK: - onViewDidLoad
    func onViewDidLoad() {
        showWeather()
    }
    
    // MARK: - Функции
    // Загружаем погоду из сети или из кэша в зависимости от того, изменилась ли локация или прошло ли более часа с момента прошлой загрузки данных
    private func showWeather() {
        if let savedLocation = userDefaults.object(forKey: "savedLocation") {
            do {
                let savedLocation = try JSONDecoder().decode(Location.self, from: savedLocation as! Data)
                if savedLocation.city == location.city {
                    checkIfExpired()
                } else {
                    fetchData()
                }
            } catch {
                print("Unable to decode location (\(error))")
            }
        } else {
            fetchData()
        }
    }
    
    // Проверяем, прошло ли более часа с момента прошлой загрузки данных, и загружаем погоду из сети или из кэша
    private func checkIfExpired(){
        if let expiredDate = userDefaults.object(forKey: "expired") as? Date {
            let timeInterval = Date.now.addingTimeInterval(3600).timeIntervalSinceReferenceDate
            let difference = Date.now.timeIntervalSinceReferenceDate - expiredDate.timeIntervalSinceReferenceDate
            if difference > timeInterval {
                userDefaults.removeObject(forKey: "savedWeather")
                fetchData()
            } else {
                configureWeatherFromCache()
            }
        }
    }
    
    // Загружаем погоду из кэша
    private func configureWeatherFromCache() {
        if let savedWeather = userDefaults.object(forKey: "savedWeather") {
            do {
                let savedWeather = try JSONDecoder().decode(WeatherModel.self, from: savedWeather as! Data)
                self.sections = self.mapToViewModel(fetchResults: savedWeather)
            } catch {
                print("Unable to decode weather (\(error))")
            }
        }
    }
    
    // Загружаем погоду их сети
    private func fetchData() {
        forecastService.getWeather(latitude: location.latitude, longitude: location.longitude) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    self?.saveDataToCache(fetchResults: weather)
                    self?.fetchResults = weather
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
    
    // Сохраняем данные в кэш
    private func saveDataToCache(fetchResults: WeatherModel) {
        do {
            let weatherData = try JSONEncoder().encode(fetchResults)
            let locationData = try JSONEncoder().encode(location)
            userDefaults.set(weatherData, forKey: "savedWeather")
            userDefaults.set(Date(), forKey: "expired")
            userDefaults.set(locationData, forKey: "savedLocation")
        } catch {
            print("Unable to encode weather (\(error))")
        }
    }
    
    // Мапим полученные данные с моделью
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
    
    // Показываем окно выбора локации
    public func showLocationSelection(){
        onOpenLocationSelection?()
    }
    
}


// MARK: - Обновляем погоду при изменении локации
extension MainScreenViewModel: LocationServiceDelegate {
    
    func locationUpdated() {
        staticLocation = locationService.currentLocation
        fetchData()
    }
    
}
