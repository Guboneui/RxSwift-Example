//
//  HttpService.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import Alamofire

protocol HttpService {
    var sessionManager: Session { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
