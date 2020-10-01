//
//  GlobalViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 3.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct GlobalPresentation {
    let worldCasesLabelText: String
    let worldDeathsLabelText: String
    let worldRecoveredLabelText: String
    let worldActiveLabelText: String
    let worldAffectedCountriesLabelText: String
    private let updated: Double
    var worldUpdatedLabelText: String {
         return String(format: NSLocalizedString("Updated at: %@", comment: ""), arguments: [getDate(time: updated)])
    }

    init(global: Global) {
        worldCasesLabelText = String(format: NSLocalizedString("Cases: %d", comment: ""), arguments: [global.cases ?? 0])
        worldDeathsLabelText = String(format: NSLocalizedString("Deaths: %d", comment: ""), arguments: [global.deaths ?? 0])
        worldRecoveredLabelText = String(format: NSLocalizedString("Recovered: %d", comment: ""), arguments: [global.recovered ?? 0])
        worldActiveLabelText = String(format: NSLocalizedString("Active: %d", comment: ""), arguments: [global.active ?? 0])
        worldAffectedCountriesLabelText = String(format: NSLocalizedString("Affected Countries: %d", comment: ""), arguments: [global.affectedCountries ?? 0])
        updated = Double(global.updated ?? 0)
    }
    
    func getDate(time: Double) -> String {
        let date = Double(time / 1000)
        let format = DateFormatter()
        format.dateFormat = "MM - dd - YYYY hh:mm a"
        return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
    }
}
