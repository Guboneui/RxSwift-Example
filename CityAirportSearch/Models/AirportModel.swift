//
//  AirportModel.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation



struct AirportModel: Decodable {
    let code: String
    let lat: String
    let lon: String
    let name: String
    let city: String
    let state: String?
    let country: String
    let woeid: String
    let tz: String
    let phone: String
    let type: String
    let email: String
    let url: String
    let runway_length: String?
    let elev: String?
    let icao: String
    let direct_flights: String?
    let carriers: String?
    

}

extension AirportModel: Equatable {
    static func == (lhs: AirportModel, rhs: AirportModel) -> Bool {
        return lhs.code == rhs.code
    }
}

extension AirportModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }
}

typealias AirportsResponse = [AirportModel]
