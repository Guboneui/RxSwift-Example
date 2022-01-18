//
//  AirportsCoordinator.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/18.
//

import Foundation
import UIKit

class AirportsCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let models: Set<AirportModel>
    
    init(models: Set<AirportModel>, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.models = models
    }
    
    override func start() {
        let view = AirportsViewController.instantiate()
        view.viewModelBuilder = { [models] in
            let title = models.first?.city ?? ""
            return AirportsViewModel(input: $0, dependencies: (title: title, models: self.models))
            
        }
        self.navigationController.pushViewController(view, animated: true)
    }
}
