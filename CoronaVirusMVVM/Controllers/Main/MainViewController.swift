
//
//  MainViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright :copyright: 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import SDWebImage
import SkeletonView

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
    private var searchListVM: CountryListViewModel!

    private var shouldAnimate = true
    private var networkReachability = NetworkReachability()

    private var globalVM: GlobalViewModel!

    var searchCountries: [Country] = []
    var isSearching = false

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

        title = "COVID-19"

        tableView.delegate = self
        tableView.dataSource = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.shouldAnimate = false
            self.tableView.reloadData()
        }

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
        navigationController?.setStatusBar(backgroundColor: UIColor(displayP3Red: 32/255, green: 200/255, blue: 182/255, alpha: 1))
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
            TimeInterval(
                exactly: date)!))
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
            return searchCountries.count
        } else {
            return self.countryListVM == nil ? 0 : self.countryListVM.numberOfRowsInSection(section)
        }

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
            fatalError("MainTableViewCell not found")
        }

        if shouldAnimate {
            cell.showAnimatedGradientSkeleton()
        } else {
            cell.hideAnimation()
        }

        let countryVM = self.countryListVM.countryAtIndex(indexPath.row)
        if isSearching {
            cell.countryLabel.text = searchCountries[indexPath.row].country
            cell.deathsLabel.text = "Deaths: \(searchCountries[indexPath.row].deaths ?? 0)"

            let url = searchCountries[indexPath.row].countryInfo?.flag != "" ? searchCountries[indexPath.row].countryInfo?.flag! : ""
            cell.countryFlagImageView.sd_setImage(with: URL(string: url!), placeholderImage: UIImage(named: "placeholder.png"))
        } else {
            cell.countryLabel.text = countryVM.country
            cell.deathsLabel.text = "Deaths: \(countryVM.deaths)"
            cell.countryFlagImageView.sd_setImage(with: URL(string: "\(String(describing: countryVM.countryFlag))"), placeholderImage: UIImage(named: "placeholder.png"))
        }
        return cell
    }
}

// MARK: - SkeletonViewTableViewDataSource

extension MainViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "MainTableViewCell"
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

        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "MainDetailViewController") as? MainDetailViewController else { return }
        var countryDetailVM = countryListVM.countryAtIndex(row)
        if isSearching {
            countryDetailVM = CountryListViewModel(countryList: searchCountries).countryAtIndex(row)
        }
        detailVC.configure(with: countryDetailVM)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCountries.removeAll()
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            return
        }

        isSearching =  textToSearch != "" ? true : false

        searchCountries = countryListVM.countryList.filter({$0.country!.prefix(searchText.count) == searchText})
        tableView.reloadData()

        stackView.layoutIfNeeded()
        stackView.isHidden = true
        worldWideLabel.text = ""
        coronaImageView.isHidden = true

        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5.0).isActive = true
        tableView.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: 10.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5.0).isActive = true

    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5.0).isActive = true
        tableView.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: 10.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5.0).isActive = true

        stackView.layoutIfNeeded()
        stackView.isHidden = true
        worldWideLabel.text = ""
        coronaImageView.isHidden = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        stackView.layoutIfNeeded()
        worldWideLabel.isHidden = false
        stackView.isHidden = false
        coronaImageView.isHidden = false
        tableView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        stackView.layoutIfNeeded()
        stackView.isHidden = false
        worldWideLabel.isHidden = false
        coronaImageView.isHidden = false
        isSearching = false
        tableView.reloadData()
    }
}

