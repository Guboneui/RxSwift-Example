//
//  AirportHttpService.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import Alamofire

class AirportHttpService: HttpService {
    var sessionManager: Session = Session.default
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
