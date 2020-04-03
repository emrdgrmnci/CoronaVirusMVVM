//
//  MainViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet private weak var worldCasesLabel: UILabel!
    @IBOutlet private weak var worldDeathsLabel: UILabel!
    @IBOutlet private weak var worldRecoveredLabel: UILabel!
    @IBOutlet private weak var worldUpdatedLabel: UILabel!
    @IBOutlet private weak var worldActiveLabel: UILabel!
    @IBOutlet private weak var worldAffectedCountriesLabel: UILabel!

    private var countryListVM: CountryListViewModel!
    private var globalVM: GlobalViewModel!

    // MARK: - View's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "COVID-19"

        tableView.delegate = self
        tableView.dataSource = self

        getAllCases()
        getAllCountries()

    }
}

// MARK: - Requests

extension MainViewController {

    func getAllCountries() {

        navigationController?.navigationBar.prefersLargeTitles = false

        let url = URL(string: "https://corona.lmao.ninja/countries?sort=country")!

        APIService().getCountries(url: url) { [weak self] countries in
            guard let self = self else { return }

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

        APIService().getGlobalCases(url: url) { [weak self] global in
            guard let self = self else { return }

            if let global = global {
                self.globalVM = GlobalViewModel(globalInfo: global)

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

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let plateLabel = UILabel()
        plateLabel.frame = CGRect(x: 10, y: 20, width: 320, height: 20)
        plateLabel.font = .boldSystemFont(ofSize: 17)
        plateLabel.textColor = .systemGray
        plateLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(plateLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Countries and Deaths"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryListVM == nil ? 0 : countryListVM.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            fatalError("MainTableViewCell not found")
        }
        let countryVM = countryListVM.countryAtIndex(indexPath.row)
        cell.configure(with: countryVM)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        routeToDetail(with: indexPath.row)
    }
}

// MARK: - Routing

extension MainViewController {

    func routeToDetail(with row: Int) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

         guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }

         let countryDetailVM = countryListVM.countryAtIndex(row)
         detailVC.configure(with: countryDetailVM)

         navigationController?.pushViewController(detailVC, animated: true)
    }
}
