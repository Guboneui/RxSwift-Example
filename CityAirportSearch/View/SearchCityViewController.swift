//
//  SearchAirportsViewController.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SearchCityViewController: UIViewController, Storyboardable {

    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: SearchCityViewPresentable!
    var viewModelBuilder: SearchCityViewPresentable.ViewModelBuilder!
    private let disposeBag = DisposeBag()
    
    private lazy var datasource = RxTableViewSectionedReloadDataSource<CityItemsSection>(configureCell: { _, tableView, indexPath, item in
        
        let cityCell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell", for: indexPath) as! CityTableViewCell
        cityCell.configure(usingViewModel: item)
        return cityCell
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = viewModelBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(), ()
        ))
        setupUI()
        setupBinding()
    }


}


private extension SearchCityViewController {
    func setupUI() -> Void {
        self.tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
        self.title = "Airports"
    }
    
    func setupBinding() -> Void {
        //self.viewModel.output.cities
        
        self.viewModel.output.cities
            .drive(tableView.rx.items(dataSource: self.datasource))
            .disposed(by: disposeBag)
    }
}
