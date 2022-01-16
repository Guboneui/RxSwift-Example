//
//  AirportAPI.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import RxSwift

protocol AirportAPI {
    func fetchAirports() -> Single<AirportsResponse>
    
}
