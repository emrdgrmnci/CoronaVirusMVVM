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
        return "Updated at: \(getDate(time: updated))"
    }
    
    init(global: Global) {
        worldCasesLabelText = "Cases: \(global.active ?? 0)"
        worldDeathsLabelText = "Deaths: \(global.deaths ?? 0)"
        worldRecoveredLabelText = "Recovered: \(global.recovered ?? 0)"
        worldActiveLabelText = "Active: \(global.active ?? 0)"
        worldAffectedCountriesLabelText = "Affected Countries: \(global.affectedCountries ?? 0)"
        updated = Double(global.updated ?? 0)
    }
    
    func getDate(time: Double) -> String {
        let date = Double(time / 1000)
        let format = DateFormatter()
        format.dateFormat = "MM - dd - YYYY hh:mm a"
        return format.string(from: Date(timeIntervalSince1970: TimeInterval(exactly: date)!))
    }
}
