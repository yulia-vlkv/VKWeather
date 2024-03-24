//
//  WeatherModel.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation

struct WeatherModel: Codable {
    var currentWeather: CurrentWeather
    var dailyWeather: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case currentWeather = "current"
        case dailyWeather = "daily"
    }
}

struct CurrentWeather: Codable {
    var sunrise: Double
    var sunset: Double
    var temperature: Float
    var humidity: Float
    var windSpeed: Float
    var clouds: Float
    var description: [Icon]
    
    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
        case temperature = "temp"
        case humidity
        case windSpeed = "wind_speed"
        case clouds
        case description = "weather"
    }
}

struct DailyWeather: Codable {
    var date: Double
    var temp: Temperature
    var description: [Icon]
    
    enum CodingKeys: String, CodingKey {
        case temp
        case date = "dt"
        case description = "weather"
    }
}

struct Temperature: Codable {
    
    var lowestTemperature: Float
    var highestTemperature: Float
    
    enum CodingKeys: String, CodingKey {
        case lowestTemperature = "min"
        case highestTemperature = "max"
    }
}

//struct DailyWeatherResponse: Codable {
//    var data: [DailyWeather]
//    
//    enum CodingKeys: String, CodingKey {
//        case data = "list"
//    }
//}
//
//struct DailyWeather: Codable {
//
//    var temp: Temperature
//    var date: Double
//    var description: [Icon]
//    
//    enum CodingKeys: String, CodingKey {
//        case temp
//        case date = "dt"
//        case description = "weather"
//    }
//}
