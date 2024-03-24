//
//  CustomColorsEnum.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import UIKit

enum CustomColors {
    
    case almostWhite
    case simpleGray
    case almostBlack
    case classicBlue
    case alertRed
    
    static func setColor (style: CustomColors) -> UIColor {
        switch style {
        case .almostWhite:
            return UIColor(named: "almostWhite")!
        case .simpleGray:
            return UIColor(named: "simpleGray")!
        case .almostBlack:
            return UIColor(named: "almostBlack")!
        case .classicBlue:
            return UIColor(named: "classicBlue")!
        case .alertRed:
            return UIColor(named: "alertRed")!
        }
    }
}
