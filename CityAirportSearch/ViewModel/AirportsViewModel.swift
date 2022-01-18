//
//  AirportsViewModel.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/18.
//

import Foundation

protocol AirportsViewPresentable {
    typealias Output = ()
    typealias Input = ()
    
    
    
    var output: AirportsViewPresentable.Output { get }
    var input: AirportsViewPresentable.Input { get }
}

struct AirportsViewModel: AirportsViewPresentable {
    
    var input: AirportsViewPresentable.Input
    var output: AirportsViewPresentable.Output
    
}
