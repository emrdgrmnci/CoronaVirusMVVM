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

    var countryArray = [Country]()
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "COVID-19"

        tableView.delegate = self
        tableView.dataSource = self

        getAllCases()
        getAllCountries()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    func getAllCountries() {

        self.navigationController?.navigationBar.prefersLargeTitles = false

        let url = URL(string: "https://corona.lmao.ninja/countries?sort=country")!

        APIService().getCountries(url: url) { (countries) in

            if let countries = countries {
                self.countryListVM = CountryListViewModel(countryList: countries.reversed())
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
                let updated = self.getDate(time: Double(self.globalVM.updated))
                DispatchQueue.main.async {
                    self.worldCasesLabel.text = "Cases: \(String(describing: self.globalVM.active))"
                    self.worldDeathsLabel.text = "Deaths: \(self.globalVM.deaths)"
                    self.worldRecoveredLabel.text = "Recovered: \(self.globalVM.recovered)"
                    self.worldUpdatedLabel.text = "Updated at: \(updated)"
                    self.worldActiveLabel.text = "Active: \(self.globalVM.active)"
                    self.worldAffectedCountriesLabel.text = "Affected Countries: \(self.globalVM.affectedCountries)"
                }
            }
        }

    }

    //getDate(time: self.globalVM.updated)

    func getDate(time: Double) -> String {
        let date = Double(time / 1000)

        let format = DateFormatter()
        format.dateFormat = "MM - dd - YYYY hh:mm a"
        return format.string(from: Date(timeIntervalSince1970:
            TimeInterval(exactly: date)!))
    }
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let countryTitleLabel = UILabel()
        countryTitleLabel.frame = CGRect(x: 10, y: 20, width: 320, height: 20)
        countryTitleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        countryTitleLabel.textColor = .systemGray
        countryTitleLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

        let headerView = UIView()
        headerView.addSubview(countryTitleLabel)

        return headerView
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Countries and Deaths"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if isSearching {
            return countryArray.count
        } else {
            return self.countryListVM == nil ? 0 : self.countryListVM.numberOfRowsInSection(section)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            fatalError("MainTableViewCell not found")
        }

        let countryVM = self.countryListVM.countryAtIndex(indexPath.row)
        if isSearching {
            cell.countryLabel.text = countryArray[indexPath.row].country
            cell.deathsLabel.text = "Deaths: \(String(describing: countryArray[indexPath.row].deaths))"
            cell.countryFlagImageView.sd_setImage(with: URL(string: "\(String(describing: countryArray[indexPath.row].countryInfo?.flag))"), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            //        let countries = [self.countryListVM.countryList[indexPath.row].country]
            cell.countryLabel.text = countryVM.country
            cell.deathsLabel.text = "Deaths: \(countryVM.deaths)"
            cell.countryFlagImageView.sd_setImage(with: URL(string: "\(String(describing: countryVM.countryFlag))"), placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }

        let countryDetailVM = self.countryListVM.countryAtIndex(indexPath.row)

        detailVC.backgroundImage.sd_setImage(with: URL(string: "\(String(describing: countryDetailVM.countryFlag))"), placeholderImage: UIImage(named: "placeholder.png"))
        detailVC.countryName = countryDetailVM.country
        detailVC.confirmedCases = countryDetailVM.cases
        detailVC.criticalCases  = countryDetailVM.critical
        detailVC.todayCases =     countryDetailVM.todayCases
        detailVC.todayDeaths =    countryDetailVM.todayDeaths
        detailVC.totalRecovered = countryDetailVM.recovered
        detailVC.totalDeaths =    countryDetailVM.deaths


        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        countryArray = countryListVM.countryList.filter({$0.country!.prefix(searchText.count) == searchText})
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        tableView.reloadData()
    }
}
