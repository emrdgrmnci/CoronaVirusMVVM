//
//  DetailViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import SDWebImage

class MainDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var confirmedCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var todayCasesLabel: UILabel!
    @IBOutlet weak var todayDeathsLabel: UILabel!
    @IBOutlet weak var criticalCasesLabel: UILabel!

    var viewModel2: MainDetailViewModelInterface!
    
    private var viewModel: CountryViewModel!
    private var searchedViewModel: CountryViewModel!
    private var networkReachability = NetworkReachability()

    // MARK: - View's Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        //MARK: - NetworkReachability

        if !networkReachability.isReachable {
            let alert = UIAlertController(title: "Oops!", message: "You're offline! Check your network connection.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }

    // MARK: - Configuration

    public func configure(with viewModel: CountryViewModel) {
        self.viewModel = viewModel
    }

    public func searchedConfigure(with viewModel: CountryViewModel) {
        self.searchedViewModel = viewModel
    }

    // MARK: - Preparation

    private func prepareView() {

        

        title = viewModel.country

        let imageURL = URL(string: viewModel.countryFlag)
        backgroundImageView.sd_setImage(with: imageURL,
                                        placeholderImage: UIImage(named: "placeholder.png"))

        confirmedCasesLabel.text = "Confirmed Cases: \(viewModel.cases)"
        totalDeathsLabel.text = "Total Deaths: \(viewModel.deaths)"
        totalRecoveredLabel.text = "Total Recovered: \(viewModel.recovered)"
        todayCasesLabel.text = "Today Cases: \(viewModel.todayCases)"
        todayDeathsLabel.text = "Today Deaths: \(viewModel.todayDeaths)"
        criticalCasesLabel.text = "Critical Cases: \(viewModel.critical)"
    }
}
