//
//  Extensions.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import UIKit


// Отключаем автоматическое создание констрейнтов
extension UIView {
    
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}


// Предложение с заглавной буквы
extension String {
    
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
    
}
