//
//  ConfigurableProtocol.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation

protocol ConfigurableView {
    
    associatedtype Model
    
    func configure(with model: Model)
    
//    func reloadData()
    
}

//extension ConfigurableView {
//    func reloadData() {
//        
//    }
//}
