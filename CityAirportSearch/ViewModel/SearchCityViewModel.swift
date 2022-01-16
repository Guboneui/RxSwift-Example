//
//  SearchCityViewModel.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchCityViewPresentable {
    
    typealias Input = (
        searchText: Driver<String>, ()
    )
    typealias Output = ()
    typealias ViewModelBuilder = (SearchCityViewPresentable.Input) -> SearchCityViewPresentable
    
    var input: SearchCityViewPresentable.Input { get }
    var output: SearchCityViewPresentable.Output { get }
}

class SearchCityViewModel: SearchCityViewPresentable {
    
    var input: SearchCityViewPresentable.Input
    var output: SearchCityViewPresentable.Output
    private let airportService: AirportAPI
    private let disposeBag = DisposeBag()
    
    init(input: SearchCityViewPresentable.Input, airportService: AirportAPI) {
        self.input = input
        self.output = SearchCityViewModel.output(input: self.input)
        self.airportService = airportService
        self.process()
    }
    
}

private extension SearchCityViewModel {
    static func output(input: SearchCityViewPresentable.Input) -> SearchCityViewPresentable.Output {
        
        return ()
    }
    
    func process() -> Void {
        self.airportService.fetchAirports()
            .map({ (airports) in
                print("Airports: \(airports)")
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
