//
//  DailyWeatherTableCellModel.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import UIKit


struct DailyWeatherTableCellModel {
    
    let date: String
    let icon: UIImage
    let description: String
    let lowestTemperature: String
    let highestTemperature: String
}

extension DailyWeatherTableCellModel  {
    
    init(with dailyWeather: DailyWeather) {
        
        self.date = {
            let date = NSDate(timeIntervalSince1970: dailyWeather.date as Double)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ru_RU")
            dateFormatter.dateFormat = "MM/dd"
            return dateFormatter.string(from: date as Date)
        }()
        
        self.icon = {
            let code = dailyWeather.description[0].iconCode
            let icon = WeatherIcon(code: code)
            return icon.iconImage
        }()
        
        self.description = dailyWeather.description[0].verbalDesctiption
        
        self.lowestTemperature = String(dailyWeather.temp.lowestTemperature)
        
        self.highestTemperature = String(dailyWeather.temp.highestTemperature)
        
    }
}
