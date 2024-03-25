//
//  LocationSelectorView.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import UIKit


class LocationSelectorView: UIAlertController {
    
    public var model: LocationSelectorViewModel!
    
    // Создаем алерт
    public static func create() -> Self {
        let alert = Self(title: "Укажите вашу локацию", message: nil, preferredStyle: .alert)
        alert.configure()
        return alert
    }
    
    // Настраиваем алерт
    private func configure() {
        addTextField() { newTextField in
            newTextField.placeholder = "Мой город"
        }
        addAction(UIAlertAction(title: "Отмена", style: .cancel) { _ in
            self.model.cancel()
        })
        addAction(UIAlertAction(title: "Ок", style: .default) { _ in
            if let textFields = self.textFields,
               let tf = textFields.first,
               let text = tf.text {
                self.model.findLocation(for: text)
            } else {
                print("Can't find the location")
            }
        })
    }
    
}

