//
//  CountryDetailPresentation.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 12.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit

struct MainDetailPresentation {
    let countryFlagImage: String
    let confirmedCasesLabelText: String
    let totalDeathsLabelText: String
    let totalRecoveredLabelText: String
    let todayCasesLabelText: String
    let todayDeathsLabelText: String
    let criticalCasesLabelText: String
    let mainDetailNavigationBarText: String

    init(country: Country) {
        countryFlagImage = country.countryInfo?.flag ?? ""
        confirmedCasesLabelText = "Confirmed Cases: \(country.cases ?? 0)"
        totalDeathsLabelText = "Total Deaths: \(country.deaths ?? 0)"
        totalRecoveredLabelText = "Today Recovered: \(country.recovered ?? 0)"
        todayCasesLabelText = "Today Cases: \(country.active ?? 0)"
        todayDeathsLabelText = "Today Deaths: \(country.todayDeaths ?? 0)"
        criticalCasesLabelText = "Critical Cases: \(country.critical ?? 0)"
        mainDetailNavigationBarText = "\(country.country ?? "No Country!")"
    }
}
