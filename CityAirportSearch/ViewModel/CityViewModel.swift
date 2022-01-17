//
//  CityViewModel.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

typealias CityItemsSection = SectionModel<Int, CityViewPresentable>

protocol CityViewPresentable {
    var city: String { get }
    var location: String { get }
    
}

struct CityViewModel: CityViewPresentable {
    
    var city: String
    var location: String
}

extension CityViewModel {
    
    init(model: AirportModel) {
        self.city = model.city
        self.location = "\(model.state ?? ""), \(model.country)"
    }
}

extension CityViewModel: Equatable {
    static func == (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        return lhs.city == rhs.city
    }
}

extension CityViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(city)
    }
}
