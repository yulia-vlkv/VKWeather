//
//  ForecastService.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import MapKit


protocol ForecastServiceDelegate: AnyObject {
    func didUpdateWeather(_ forecastService: ForecastService, currentWeather: WeatherModel)
    func didFailWithError(error: Error)
}

enum ForecastServiceError: Error {
    case noData
    case cantParse
    case unknown
}

class ForecastService {
    
    weak var delegate: ForecastServiceDelegate?
    
    private let baseURL = "https://api.openweathermap.org/data/3.0/onecall?units=metric&lang=ru"
    
    // MARK: - Получаем ключ из property list
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
    
    // MARK: - Формируем URL адрес
    private func getURLString(latitude: String, longitude: String) -> String  {
        let urlString = "\(baseURL)&appid=\(apiKey)&lat=\(latitude)&lon=\(longitude)"
        return urlString
    }
    
    // MARK: - Осуществляем запрос
    private func performRequest(with urlString: String, complition: @escaping (Result<WeatherModel, ForecastServiceError>) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    do {
                        let result = try JSONDecoder().decode(WeatherModel.self, from: safeData)
                        complition(.success(result))
                    } catch {
                        complition(.failure(.cantParse))
                    }
                }
            }
            task.resume()
        }
    }
    
    // MARK: - Получаем погоду по строке
    public func getWeather(latitude: String, longitude: String, complition: @escaping (Result<WeatherModel, ForecastServiceError>) -> Void) {
        let urlString = getURLString(latitude: latitude, longitude: longitude)
        performRequest(with: urlString, complition: complition)
    }

}

