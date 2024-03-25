//
//  CurrentWeatherTableCellModel.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//


import Foundation


// MARK: - Вьюмодель для ячейки с подробной погодой на текущий день
struct CurrentWeatherTableCellModel {
    
    let currentTemperature: String
    let verbalDescription: String
    let clouds: String
    let windSpeed: String
    let humidity: String
    let sunriseTime: String
    let sunsetTime: String
    let dateTime: String
    let dayOfWeek: String
    
    init(with currentWeather: CurrentWeather, currentDate: Date) {
        
        self.currentTemperature = String(format: "%.0f", currentWeather.temperature)
        
        self.verbalDescription = currentWeather.description[0].verbalDesctiption
        
        self.clouds = String(Int(currentWeather.clouds))
        
        self.windSpeed =  String(currentWeather.windSpeed)
        
        self.humidity = String(Int(currentWeather.humidity))
        
        self.sunriseTime = {
            let date = NSDate(timeIntervalSince1970: currentWeather.sunrise as Double)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date as Date)
        }()
        
        self.sunsetTime = {
            let date = NSDate(timeIntervalSince1970: currentWeather.sunset as Double)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: date as Date)
        }()
        
        self.dateTime =  {
            let date = currentDate
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "HH:mm, d MMMM"
            return dateFormatter.string(from: date)
        }()
        
        self.dayOfWeek = {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "EE"
            let result = dateFormatter.string(from: date)
            return result.lowercased()
        }()
    }
    
}

