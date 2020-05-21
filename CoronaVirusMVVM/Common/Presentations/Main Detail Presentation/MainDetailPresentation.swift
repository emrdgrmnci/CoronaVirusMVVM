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
        confirmedCasesLabelText = String(format: NSLocalizedString("Confirmed Cases: %d", comment: ""), arguments: [country.cases ?? 0])
        totalDeathsLabelText = String(format: NSLocalizedString("Total Deaths: %d", comment: ""), arguments: [country.deaths ?? 0])
        totalRecoveredLabelText = String(format: NSLocalizedString("Today Recovered: %d", comment: ""), arguments: [country.recovered ?? 0])
        todayCasesLabelText = String(format: NSLocalizedString("Today Cases: %d", comment: ""), arguments: [country.active ?? 0])
        todayDeathsLabelText = String(format: NSLocalizedString("Today Deaths: %d", comment: ""), arguments: [country.todayDeaths ?? 0])
        criticalCasesLabelText = String(format: NSLocalizedString("Critical Cases: %d", comment: ""), arguments: [country.critical ?? 0])
        mainDetailNavigationBarText = "\(country.country ?? "No Country!")"
    }
}
