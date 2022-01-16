//
//  AppCoordinator.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController = {
        
        
        
        
        
        let navigationController = UINavigationController()
        
//
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 28.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]

        appearance.backgroundColor = UIColor(red: 233.0/255.0, green: 55.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        //UINavigationBar.appearance().titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 28.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        //UINavigationBar.appearance().isTranslucent = false

       
        
        
//        let navigationBar = navigationController.navigationBar
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
//        navigationBar.backgroundColor = UIColor(red: 233.0/255.0, green: 55.0/255.0, blue: 72.0/255.0, alpha: 1.0)
//        navigationBar.barTintColor = UIColor(red: 233.0/255.0, green: 55.0/255.0, blue: 72.0/255.0, alpha: 1.0)
//        navigationBar.tintColor = .white
//        navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 28.0)!, NSAttributedString.Key.foregroundColor: UIColor.white]
//        navigationBar.isTranslucent = false
        
        
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let searchCityCoordinator = SearchCityCoordinator(navigationController: navigationController)
        self.add(coordinator: searchCityCoordinator)
        searchCityCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
