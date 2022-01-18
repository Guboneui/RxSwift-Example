//
//  AirportsViewController.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/18.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class AirportsViewController: UIViewController, Storyboardable {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: AirportsViewPresentable!
    var viewModelBuilder: AirportsViewPresentable.ViewModelBuilder!
    private var disposeBag = DisposeBag()
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<AirportItemSection>(configureCell: { (_, tableView, indexPath, item) in
        let airportCell = tableView.dequeueReusableCell(withIdentifier: "AirportTableViewCell", for: indexPath) as! AirportTableViewCell
        airportCell.configure(usingViewModel: item)
        return airportCell
        
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = viewModelBuilder(())
        self.setupUI()
        self.setupBinding()

    }
    
}


private extension AirportsViewController {
    func setupUI() -> Void {
        tableView.register(UINib(nibName: "AirportTableViewCell", bundle: nil), forCellReuseIdentifier: "AirportTableViewCell")
    }
    
    func setupBinding() -> Void {
        
        self.viewModel.output.airports
            .drive(self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        self.viewModel.output.title
            .drive(self.rx.title)
            .disposed(by: disposeBag)
    }
}
