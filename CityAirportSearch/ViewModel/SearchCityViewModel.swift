//
//  SearchCityViewModel.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

protocol SearchCityViewPresentable {
    
    typealias Input = (
        searchText: Driver<String>,
        citySelect: Driver<CityViewModel>
    )
    typealias Output = (
        cities: Driver<[CityItemsSection]>, ()
    )
    typealias ViewModelBuilder = (SearchCityViewPresentable.Input) -> SearchCityViewPresentable
    
    var input: SearchCityViewPresentable.Input { get }
    var output: SearchCityViewPresentable.Output { get }
}

class SearchCityViewModel: SearchCityViewPresentable {
    
    var input: SearchCityViewPresentable.Input
    var output: SearchCityViewPresentable.Output
    private let airportService: AirportAPI
    private let disposeBag = DisposeBag()
    
    typealias State = (airports: BehaviorRelay<Set<AirportModel>>, ())
    private let state: State = (airports: BehaviorRelay<Set<AirportModel>>(value: []), ())
    
    private typealias RoutingAction = (citySelectedRelay: PublishRelay<Set<AirportModel>>, ())
    private let routingAction: RoutingAction = (citySelectedRelay: PublishRelay(), ())
    
    typealias Routing = (citySelected: Driver<Set<AirportModel>>, ())
    lazy var router: Routing = (citySelected: routingAction.citySelectedRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: SearchCityViewPresentable.Input, airportService: AirportAPI) {
        self.input = input
        self.output = SearchCityViewModel.output(input: self.input, state: self.state)
        self.airportService = airportService
        self.process()
    }
    
}

private extension SearchCityViewModel {
    static func output(input: SearchCityViewPresentable.Input, state: State) -> SearchCityViewPresentable.Output {
        
        let searchTextObservable = input.searchText
            .debounce(.microseconds(300))
            .distinctUntilChanged()
            .skip(1)
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        let airportsObservable = state.airports
            .skip(1)
            .asObservable()
        
        let sections = Observable.combineLatest(
//            input.searchText.asObservable(),
//            state.airports.asObservable()
            searchTextObservable,
            airportsObservable
        ).map ({ (searchKey, airports) in
            return airports.filter { airport -> Bool in
                !searchKey.isEmpty && airport.city.lowercased()
                    .replacingOccurrences(of: " ", with: "")
                    .hasPrefix(searchKey.lowercased())
            }
        }).map ({
            //print($0)
            SearchCityViewModel.uniqueElementsFrom(array: $0.compactMap({CityViewModel(model: $0)}))
            
        }).map({[CityItemsSection(model: 0, items: $0)]})
            .asDriver(onErrorJustReturn: [])
        return (
            cities: sections, ()
        )
    }
    
    func process() -> Void {
        self.airportService
            .fetchAirports()
            .map({Set($0)})
            .map({ [state] in
                //print("Airports: \(airports)")
                state.airports.accept($0)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        self.input.citySelect
            .map { $0.city }
            .withLatestFrom(state.airports.asDriver()) { ($0, $1) }
            .map {(city, airports) in
                airports.filter({$0.city == city})
            }
            .map ({ [routingAction] in
                routingAction.citySelectedRelay.accept($0)
                //print("Airports selected: \($0)")
            })
            .drive()
            .disposed(by: disposeBag)
    }
}

private extension SearchCityViewModel {
    static func uniqueElementsFrom(array: [CityViewModel]) -> [CityViewModel] {
        // create an empty set to track unique items
        var set = Set<CityViewModel>()
        let result = array.filter {
            guard !set.contains($0) else {
                // if the set already contains this object, return false
                // so we skip it
                return false
            }
            // add this item to the set since it will now be in the array
            set.insert($0)
            // return true so that filtered array will contain this item
            return true
        }
        return result
    }
}
