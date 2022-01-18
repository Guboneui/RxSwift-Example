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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let view = AirportsViewController.instantiate()
        self.navigationController.pushViewController(view, animated: true)
    }
}
