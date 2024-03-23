//
//  CurrentWeatherTableCellModel.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//


import Foundation


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
        
        self.currentTemperature = String(currentWeather.main.currentTemperature)
        
        self.verbalDescription = currentWeather.description[0].verbalDesctiption
        
        self.clouds = String(Int(currentWeather.clouds.all))
        
        self.windSpeed =  String(currentWeather.wind.speed)
        
        self.humidity = String(Int(currentWeather.main.humidity))
        
        self.sunriseTime = {
            let date = NSDate(timeIntervalSince1970: currentWeather.sun.sunriseTime as Double)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "HH:mm, d MMMM"
            return dateFormatter.string(from: date as Date)
        }()
        
        self.sunsetTime = {
            let date = NSDate(timeIntervalSince1970: currentWeather.sun.sunsetTime as Double)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "HH:mm, d MMMM"
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


