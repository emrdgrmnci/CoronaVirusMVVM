//
//  DetailViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var confirmedCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var todayCasesLabel: UILabel!
    @IBOutlet weak var todayDeathsLabel: UILabel!
    @IBOutlet weak var criticalCasesLabel: UILabel!

    var confirmedCases = Int()
    var totalDeaths = Int()
    var totalRecovered = Int()
    var todayCases = Int()
    var todayDeaths = Int()
    var criticalCases = Int()
    var countryName = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = countryName

        confirmedCasesLabel.text = "Confirmed Cases: \(confirmedCases)"
        totalDeathsLabel.text = "Total Deaths: \(totalDeaths)"
        totalRecoveredLabel.text = "Total Recovered: \(totalRecovered)"
        todayCasesLabel.text = "Today Cases: \(todayCases)"
        todayDeathsLabel.text = "Today Deaths: \(todayDeaths)"
        criticalCasesLabel.text = "Critical Cases: \(criticalCases)"
    }
}
