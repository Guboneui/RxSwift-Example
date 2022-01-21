//
//  AirportViewModel.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/19.
//

import Foundation
import CoreLocation

protocol AirportViewPresentable {
    var name: String { get }
    var code: String { get }
    var address: String { get }
    var distance: Double? { get }
    var formattedDistance: String { get }
    var runwayLength: String { get }
    var location: (lat: String, lon: String) { get }
    
}

struct AirportViewModel: AirportViewPresentable {
    
    var formattedDistance: String {
        return "\(distance?.rounded(.toNearestOrEven) ?? 0 / 1000) KM"
    }
    var name: String
    var code: String
    var address: String
    var distance: Double?
    var runwayLength: String
    var location: (lat: String, lon: String)
}

extension AirportViewModel {
    
    init(usingModel model: AirportModel, currentLocation: (lat: Double, lon: Double)) {
        self.name = model.name
        self.code = model.code
        self.address = "\(model.state ?? ""), \(model.country)"
        self.runwayLength = "Runway Length: \(model.runway_length ?? "NA")"
        self.location = (lat: model.lat, lon: model.lon)
        /// Fix Me - Distancing calculation from current location to airport
        self.distance = AirportViewModel.getDistance(airportLocation: (lat: Double(model.lat), lon: Double(model.lon)), currentLocation: currentLocation)
    }
}

extension AirportViewModel {
    static func getDistance(airportLocation: (lat: Double?, lon: Double?),
                     currentLocation: (lat: Double, lon: Double)) -> Double? {
        
        guard let airportLat = airportLocation.lat,
              let airportLon = airportLocation.lon else { return nil }
        let current = CLLocation(latitude: currentLocation.lat, longitude: currentLocation.lon)
        let airport = CLLocation(latitude: airportLat, longitude: airportLon)
        return current.distance(from: airport)
    }
}
