//
//  MainViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import Foundation
import SDWebImage

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var worldCasesLabel: UILabel!
    @IBOutlet weak var worldDeathsLabel: UILabel!
    @IBOutlet weak var worldRecoveredLabel: UILabel!
    @IBOutlet weak var worldUpdatedLabel: UILabel!
    @IBOutlet weak var worldActiveLabel: UILabel!
    @IBOutlet weak var worldAffectedCountriesLabel: UILabel!

    private var countryListVM: CountryListViewModel!
    private var globalVM: GlobalViewModel!

    //       init(globalVM: GlobalViewModel) {
    //           self.globalVM = globalVM
    //        super.init(nibName: nil, bundle: nil)
    //       }


    override func viewDidLoad() {
        super.viewDidLoad()
        //        globalVM = self.globalVM.getAllCases()
        tableView.delegate = self
        tableView.dataSource = self

        getAllCases()
        getAllCountries()
        //        getWorld()

    }

    //    private func getWorld() {
    //    }

    func getAllCountries() {

        self.navigationController?.navigationBar.prefersLargeTitles = false

        let url = URL(string: "https://corona.lmao.ninja/countries?sort=country")!

        APIService().getCountries(url: url) { (countries) in

            if let countries = countries {
                self.countryListVM = CountryListViewModel(countryList: countries)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

    }

    func getAllCases() {

        let url = URL(string: "https://corona.lmao.ninja/all")!

        APIService().getGlobalCases(url: url) { (global) in

            if let global = global {
                self.globalVM = GlobalViewModel(global)

                DispatchQueue.main.async {
                    self.worldCasesLabel.text = "Cases: \(String(describing: self.globalVM.active))"
                    self.worldDeathsLabel.text = "Deaths: \(self.globalVM.deaths)"
                    self.worldRecoveredLabel.text = "Recovered: \(self.globalVM.recovered)"
                    self.worldUpdatedLabel.text = "Active: \(self.globalVM.updated)"
                    self.worldActiveLabel.text = "Active: \(self.globalVM.active)"
                    self.worldAffectedCountriesLabel.text = "Affected Countries: \(self.globalVM.affectedCountries)"
                }
            }
        }

    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryListVM == nil ? 0 : self.countryListVM.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            fatalError("MainTableViewCell not found")
        }
        let countryVM = self.countryListVM.countryAtIndex(indexPath.row)
        cell.countryLabel.text = countryVM.country
        cell.deathsLabel.text = "Deaths: \(countryVM.deaths)"
        cell.countryFlagImageView.sd_setImage(with: URL(string: "\(String(describing: countryVM.countryFlag))"), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        ////        let countryVM = self.countryListVM.countryAtIndex(indexPath.row)
        //        let globalVM = self.globalListVM.allCase()
        //
        //
        //              let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //              guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        //        detailVC.confirmedCases = globalVM.cases
        //        detailVC.criticalCases = globalVM.
        //        detailVC.confirmedCases = globalVM.cases
        //        detailVC.confirmedCases = globalVM.cases
        //        detailVC.confirmedCases = globalVM.cases
    }
}
