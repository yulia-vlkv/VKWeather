//
//  WeatherIcon.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import UIKit


// MARK: - Модель иконки
struct Icon: Codable {
    
    var iconCode: Int
    var verbalDesctiption: String
    
    enum CodingKeys: String, CodingKey {
        case iconCode = "id"
        case verbalDesctiption = "description"
    }
    
}

// MARK: - Тип иконки
enum WeatherIconType {
    case clearSky
    case cloudly
    case thunder
    case snow
    case rain
    case fog
    case unknown
}

// MARK: - Соответствие кода получаемой иконки с типом иконки
extension WeatherIconType {
    
    init(code: Int) {
        let clearSky = [800]
        let cloudy = [801, 802, 803, 804]
        let thunder = [200, 201, 202, 230, 231, 232, 233]
        let snow = [600, 601, 602, 610, 611, 612, 621, 622, 623]
        let rain = [300, 301, 302, 500, 501, 502, 511, 520, 521, 522]
        let fog = [700, 711, 721, 731, 741, 751]
        
        if clearSky.contains(code) {
            self = .clearSky
        } else if cloudy.contains(code) {
            self = .cloudly
        } else if thunder.contains(code) {
            self = .thunder
        } else if snow.contains(code) {
            self = .snow
        } else if rain.contains(code) {
            self = .rain
        } else if fog.contains(code) {
            self = .fog
        } else {
            self = .unknown
        }
    }
    
}


// MARK: - Класс, описывающий иконку
class WeatherIcon {
    
    // Получаемый код иконки
    let code: Int
    // Тип иконки
    let weaterIconType: WeatherIconType
    // Изображение
    let iconImage: UIImage

    init (code: Int) {
        self.code = code
        self.weaterIconType = WeatherIconType(code: code)
        self.iconImage = WeatherIcon.getImage(for: self.weaterIconType)
    }
    
    // Функция, которая выдает изображение по типу иконки
    private static func getImage(for type: WeatherIconType) -> UIImage {
        
        switch type {
        case .clearSky:
            return UIImage(systemName: "sun.max.fill")!
        case .cloudly:
            return UIImage(systemName: "cloud.sun.fill")!
        case .thunder:
            return UIImage(systemName: "cloud.bolt.rain.fill")!
        case .snow:
            return UIImage(systemName: "cloud.snow.fill")!
        case .rain:
            return UIImage(systemName: "cloud.rain.fill")!
        case .fog:
            return UIImage(systemName: "cloud.fog.fill")!
        case .unknown:
            return UIImage(systemName: "sun.max.fill")!
        }
    }
    
}

