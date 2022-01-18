//
//  AirportTableViewCell.swift
//  CityAirportSearch
//
//  Created by 구본의 on 2022/01/19.
//

import UIKit

class AirportTableViewCell: UITableViewCell {

    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(usingViewModel viewModel: AirportViewPresentable) -> Void {
        airportNameLabel.text = viewModel.name
        distanceLabel.text = viewModel.formattedDistance
        countryLabel.text = viewModel.address
        lengthLabel.text = viewModel.runwayLength
        self.selectionStyle = .none
    }
    
}
