//
//  MainTableViewCell.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        showAnimatedSkeleton()

    }
    func hideAnimation() {
        hideSkeleton()
    }


    func configure(with viewModel: CountryViewModel) {
        countryLabel.text = viewModel.country
        deathsLabel.text = "Deaths: \(viewModel.deaths)"

        let imageURL = URL(string: viewModel.countryFlag)
        countryFlagImageView.sd_setImage(with: imageURL,
                                         placeholderImage: UIImage(named: "placeholder.png"))
    }
}
