//
//  SearchCityCoordinator.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SearchCityCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    override func start() {
        let view = SearchCityViewController.instantiate()
        let service = AirportService.shared
        
        view.viewModelBuilder = { [disposeBag] in
            let viewModel = SearchCityViewModel(input: $0, airportService: service)
            viewModel.router.citySelected.map { [weak self] models in
                guard let self = self else {return}
                self.showAirports(usingModel: models)
                //print("models received = \(models)")
            }
            .drive()
            .disposed(by: disposeBag)
            return viewModel
        }
        navigationController.pushViewController(view, animated: true)
        
    }
}

private extension SearchCityCoordinator {
    func showAirports(usingModel models: Set<AirportModel>) -> Void {
        let airportsCoordinator = AirportsCoordinator(models: models, navigationController: self.navigationController)
        self.add(coordinator: airportsCoordinator)
        airportsCoordinator.start()
    }
}
