//
//  AirportService.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import RxSwift
import Alamofire

class AirportService {
    private lazy var httpService = AirportHttpService()
    static let shared: AirportService = AirportService()
}

//extension AirportService: AirportAPI {
//    func fetchAirports() -> Single<AirportsResponse> {
//        return Single<AirportsResponse>.create{[httpService] (single) -> Disposable in
//
//            do {
//                try AirportHttpRouter.getAirports
//                    .request(usingHttpService: httpService)
//                    .responseJSON { (result) in
//                        guard let data = result.data else {return}
//
//                        do {
//                            let airports = try JSONDecoder().decode(AirportsResponse.self, from: data)
//
//                            single(.success(airports))
//                        } catch {
//                            print("Airports fetch failed with error: \(error)")
//                        }
//
//                    }
//            } catch {
//
//            }
//
//
//            return Disposables.create()
//        }
//    }
//}

extension AirportService: AirportAPI {
    func fetchAirports() -> Single<AirportsResponse> {
        return Single<AirportsResponse>.create{[httpService] (single) -> Disposable in
            
            do {
                try AirportHttpRouter.getAirports
                    .request(usingHttpService: httpService)
                    .responseJSON { (result) in
                        
                        
                        do {
                        
                            let airports = try AirportService.parseAirports(result: result)
                            single(.success(airports))
                        } catch {
                            single(.failure(error))
                            print("Airports fetch failed with error: \(error)")
                        }
                        
                    }
            } catch {
                single(.failure(CustomError.error(value: "Airports fetch failed")))
            }
            
            
            return Disposables.create()
        }
    }
}


extension AirportService {
    static func parseAirports(result: AFDataResponse<Any>) throws -> AirportsResponse {
        guard let data = result.data,
              let airportsResponse = try? JSONDecoder().decode(AirportsResponse.self, from: data) else {
                  throw CustomError.error(value: "Invalid airports Json")
              }
        return airportsResponse
    }
}
