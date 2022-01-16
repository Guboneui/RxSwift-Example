//
//  SearchAirportsViewController.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCityViewController: UIViewController {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SearchCityViewPresentable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

