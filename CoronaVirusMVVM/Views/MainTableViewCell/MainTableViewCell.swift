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

    func configure(with country: Country) {
        countryLabel.text = country.country
        deathsLabel.text = "Deaths: \(country.deaths ?? 0)"
        countryFlagImageView.setImage(with: country.countryInfo?.flag)
    }
}
