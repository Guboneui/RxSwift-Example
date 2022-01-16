//
//  BaseCoordinator.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    func start() {
        fatalError("Children should implement start")
    }
}
