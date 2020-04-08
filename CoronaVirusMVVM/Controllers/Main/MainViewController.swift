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

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var worldWideLabel: UILabel!
    @IBOutlet weak var coronaImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet private weak var worldCasesLabel: UILabel!
    @IBOutlet private weak var worldDeathsLabel: UILabel!
    @IBOutlet private weak var worldRecoveredLabel: UILabel!
    @IBOutlet private weak var worldUpdatedLabel: UILabel!
    @IBOutlet private weak var worldActiveLabel: UILabel!
    @IBOutlet private weak var worldAffectedCountriesLabel: UILabel!

    private var countryListVM: CountryListViewModel!
    private var globalVM: GlobalViewModel!

    var countryArray = [Country]()
    var isSearching = false

    // MARK: - View's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "COVID-19"

        tableView.delegate = self
        tableView.dataSource = self

        getAllCases()
        getAllCountries()
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        worldWideLabel.text = "Worldwide"
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        isSearching = false
        tableView.reloadData()
    }

    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.clearButtonMode = .whileEditing
        navigationItem.searchController = searchController
        //        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

// MARK: - Requests

extension MainViewController {

    func getAllCountries() {

        navigationController?.navigationBar.prefersLargeTitles = false

        let url = URL(string: "https://corona.lmao.ninja/countries?sort=country")!

        APIService().getCountries(url: url) { [weak self] countries in
            guard let self = self,
                let countries = countries else { return }

            self.countryListVM = CountryListViewModel(countryList: countries.reversed())

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    func getAllCases() {

        let url = URL(string: "https://corona.lmao.ninja/all")!

        APIService().getGlobalCases(url: url) { [weak self] global in
            guard let self = self else { return }

            if let global = global {
                self.globalVM = GlobalViewModel(globalInfo: global)
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

// MARK: - UITableViewDataSource

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
            cell.deathsLabel.text = "Deaths: \(countryArray[indexPath.row].deaths ?? 0)"
            cell.countryFlagImageView.sd_setImage(with: URL(string: "\(String(describing: countryVM.countryFlag))"), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            //        let countries = [self.countryListVM.countryList[indexPath.row].country]
            cell.countryLabel.text = countryVM.country
            cell.deathsLabel.text = "Deaths: \(countryVM.deaths)"
            cell.countryFlagImageView.sd_setImage(with: URL(string: "\(String(describing: countryVM.countryFlag))"), placeholderImage: UIImage(named: "placeholder.png"))
        }
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

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        stackView.layoutIfNeeded()
        stackView.isHidden = true
        worldWideLabel.text = ""
        coronaImageView.isHidden = true

        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5.0).isActive = true
        tableView.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: 10.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5.0).isActive = true


        countryArray = countryListVM.countryList.filter({$0.country!.prefix(searchText.count) == searchText})
        isSearching = true
        tableView.reloadData()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)

        stackView.layoutIfNeeded()
        stackView.isHidden = false
        coronaImageView.isHidden = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        stackView.layoutIfNeeded()
        stackView.isHidden = false
        worldWideLabel.isHidden = false
        coronaImageView.isHidden = false
        isSearching = false
        tableView.reloadData()

    }
}
