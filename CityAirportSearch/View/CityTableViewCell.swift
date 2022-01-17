//
//  CityTableViewCell.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/17.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(usingViewModel viewModel: CityViewPresentable) {
        self.cityLabel.text = viewModel.city
        self.locationLabel.text = viewModel.location
    }
}
