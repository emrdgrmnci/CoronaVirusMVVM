//
//  MainPresentation.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 13.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit

struct MainPresentation {

    let countryLabelText: String
    let deathsLabelText: Int
    let countryFlagImageView: String

    init(country: Country) {
        countryLabelText = country.country ?? ""
        deathsLabelText = country.deaths ?? 0
        countryFlagImageView = country.countryInfo?.flag ?? ""
    }
}
