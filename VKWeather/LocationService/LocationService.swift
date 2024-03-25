//
//  LocationService.swift
//  VKWeather
//
//  Created by Iuliia Volkova on 23.03.2024.
//

import Foundation
import CoreLocation


protocol LocationServiceDelegate: AnyObject {
    func locationUpdated()
}


// MARK: - Описание локации
struct Location: Codable {
    let city: String
    let country: String
    let longitude: String
    let latitude: String
}


// MARK: - LocationService
class LocationService: NSObject {
    
    weak var locationDelegate: LocationServiceDelegate?

    static var shared = LocationService()
    
    public var currentLocation: Location?
    
    private lazy var locationManager = CLLocationManager()
    private var locationPermissionResult: ((Bool) -> Void)?

    override init() {
        super.init()
        
        locationManager.delegate = self
        checkUserLocationPermissions()
    }
    
    // MARK: - Получаем текущую локацию, если есть досьуп к геолокации
    public func getLocation(){
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            if let location = locationManager.location {
                configureCurrentLocation(location: location)
            }
        }
    }
    
    // MARK: - Получаем текущую локацию
    private func configureCurrentLocation(location: CLLocation) {
        self.getLocationFromCoordinates(for: location) { placemark in
            DispatchQueue.main.async {
                guard let placemark = placemark else { return }
                
                let placeForWeather = Location(
                    city: placemark.locality ?? "Неизвестно",
                    country: placemark.country ?? "Неизвестно",
                    longitude: String(location.coordinate.longitude),
                    latitude: String(location.coordinate.latitude)
                )
                self.currentLocation = placeForWeather
                self.locationDelegate?.locationUpdated()
            }
        }
    }
    
    // MARK: - Проверяем, есть ли доступ к геолокации
    public func checkUserLocationPermissions(response: ((Bool) -> Void)? = nil) {
    
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationPermissionResult = response
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            if let location = locationManager.location {
                print("[DEBUG] Setup current location to: \(location)")
                configureCurrentLocation(location: location)
                response?(true)
            }
            
        case .denied, .restricted:
            print("DENIED")
            response?(false)
            
        @unknown default:
            fatalError("Не обрабатываемый статус")
        }
    }
    
    // MARK: - Функции CLGeocoder
    // Получаем локацию по координатам
    public func getLocationFromCoordinates(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    
    // Получаем локацию по строке (город)
    public func getLocationFromString(from address: String,
                     completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }
    
}


// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location {
            configureCurrentLocation(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            
        case .notDetermined:
            break
            
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = manager.location {
                configureCurrentLocation(location: location)
            }
            locationPermissionResult?(true)
            locationPermissionResult = nil
            
        case .denied, .restricted:
            locationPermissionResult?(false)
            locationPermissionResult = nil
            
        @unknown default:
            fatalError("Не обрабатываемый статус")
        }
    }
    
}
