//
//  LocationService.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/21.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa
import RxRelay

final class LocationService: NSObject {
    
    // 싱글톤 생성
    static let shared: LocationService = LocationService()
    private let manager = CLLocationManager()
    
    private let currentLocationRelay: BehaviorRelay<(lat: Double, lon: Double)?> = BehaviorRelay(value: nil)
    lazy var currentLocation: Observable<(lat: Double, lon: Double)?> = self.currentLocationRelay.asObservable().share(replay: 1, scope: .forever)
    
    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        manager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
    }
    
    deinit {
        manager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let currentLocation = (
                lat: location.coordinate.latitude,
                lon: location.coordinate.longitude
            )
            currentLocationRelay.accept(currentLocation)
        }
        manager.stopUpdatingLocation()
    }
}
