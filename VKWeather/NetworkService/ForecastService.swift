//
//  ForecastService.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import MapKit

protocol ForecastServiceDelegate: AnyObject {
    func didUpdateWeather(_ forecastService: ForecastService, currentWeather: CurrentWeather, dailyWeather: DailyWeather)
    func didFailWithError(error: Error)
}

enum ForecastServiceError: Error {
    case noData
    case unknown(Error)
}

class ForecastService {
    
    weak var delegate: ForecastServiceDelegate?
    
    private let baseURLCurrent = "https://api.openweathermap.org/data/2.5/weather?units=metric&lang=ru"
    private let baseURLDaily = "https://api.openweathermap.org/data/2.5/forecast/daily?&cnt=7&units=metric&lang=ru"
    
    private var apiKey: String {
      get {
        guard let filePath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
          fatalError("Couldn't find file 'Keys.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "weatherApiKey") as? String else {
          fatalError("Couldn't find key 'weatherApiKey' in 'Keys.plist'.")
        }
        return value
      }
    }
    
//    func fetchWeather(cityName: String) {
//        let urlString = "\(baseURL)&appid=\(apiKey)&q=\(cityName)"
//        performRequest(with: urlString)
//    }
    
    func fetchCurrentWeather(latitude: String, longitude: String) {
        let urlString = "\(baseURLCurrent)&appid=\(apiKey)&lat=\(latitude)&lon=\(longitude)"
            self.performRequest(with: urlString)
    }
    
    func fetchDailyWeather(latitude: String, longitude: String) {
        let urlString = "\(baseURLDaily)&appid=\(apiKey)&lat=\(latitude)&lon=\(longitude)"
            self.performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
//                    if let weather = self.parseJSON(weatherData: safeData) {
//                        self.delegate?.didUpdateWeather(self, weather: weather)
//                    }
                    print(String(data: safeData, encoding: .utf8))
                }
            }
            task.resume()
        }
    }
    
//    func parseJSON(weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherModel.self, from: weatherData)
//            let current = decodedData.current
//            let daily = decodedData.daily
//            
//            let weather = WeatherModel(current: current, daily: daily)
//            print(weather)
//            return weather
//        } catch {
//            self.delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
}
