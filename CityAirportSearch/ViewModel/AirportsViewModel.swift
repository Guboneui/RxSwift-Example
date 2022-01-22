//
//  AirportsViewModel.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/18.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias AirportItemSection = SectionModel<Int, AirportViewPresentable>

protocol AirportsViewPresentable {
    typealias Output = (
        title: Driver<String>,
        airports: Driver<[AirportItemSection]>
    )
    
    typealias Input = ()
    
    typealias Dependencies = (
        title: String,
        models: Set<AirportModel>,
        currentLocation: Observable<(lat: Double, lon: Double)?>
    )
    
    typealias ViewModelBuilder = (AirportsViewPresentable.Input) -> AirportsViewPresentable
    
    var output: AirportsViewPresentable.Output { get }
    var input: AirportsViewPresentable.Input { get }
}

struct AirportsViewModel: AirportsViewPresentable {
    
    var input: AirportsViewPresentable.Input
    var output: AirportsViewPresentable.Output
    
    init(input: AirportsViewPresentable.Input, dependencies: AirportsViewPresentable.Dependencies) {
        self.input = input
        self.output = AirportsViewModel.output(dependencies: dependencies)
        
    }
}

private extension AirportsViewModel {
    static func output(dependencies: AirportsViewPresentable.Dependencies) -> AirportsViewPresentable.Output {
        
        let sections = Observable.just(dependencies.models)
            .withLatestFrom(dependencies.currentLocation) { (models: $0, location: $1) }
            .map({ arg in
                arg.models.compactMap { AirportViewModel(
                    usingModel: $0,
                    currentLocation: arg.location ?? (lat: 0, lon: 0))
                }.sorted()
            })
            
            .map {[AirportItemSection(model: 0, items: $0)]}
            .asDriver(onErrorJustReturn: [])
        return (
            title: Driver.just(dependencies.title),
            airports: sections
        )
    }
}
