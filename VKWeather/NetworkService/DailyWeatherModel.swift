//
//  DailyWeatherModel.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation

struct DailyWeatherResponse: Codable {
    var data: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case data = "list"
    }
}

struct DailyWeather: Codable {

    var temp: Temperature
    var date: Double
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
