//
//  WeatherModel.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation


struct CurrentWeather: Codable {
    var main: Main
    var description: [Icon]
    var wind: Wind
    var clouds: Clouds
    var sun: Sun
    
    enum CodingKeys: String, CodingKey {
        case main
        case description = "weather"
        case wind
        case clouds
        case sun = "sys"
    }
}

struct Main: Codable {
    var currentTemperature: Float
    var humidity: Float
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case humidity
    }
}

struct Wind: Codable {
    var speed: Float
    
    enum CodingKeys: String, CodingKey {
        case speed
    }
}

struct Clouds: Codable {
    var all: Float
    
    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct Sun: Codable {
    var sunriseTime: Double
    var sunsetTime: Double
    
    enum CodingKeys: String, CodingKey {
        case sunriseTime = "sunrise"
        case sunsetTime = "sunset"
    }
}
