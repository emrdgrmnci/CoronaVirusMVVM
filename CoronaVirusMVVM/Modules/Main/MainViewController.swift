
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

    var viewModel: MainViewModelInterface! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private var shouldAnimate = true
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

        title = "COVID-19"

        tableView.delegate = self
        tableView.dataSource = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.shouldAnimate = false
            self.tableView.reloadData()
        }
        
        viewModel.getAllCountries()
        viewModel.getAllCases()
        
        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        worldWideLabel.text = "Worldwide"
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }

    // MARK: - NavigationBar
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setStatusBar(backgroundColor: UIColor(displayP3Red: 32/255, green: 200/255, blue: 182/255, alpha: 1))
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.clearButtonMode = .whileEditing
        navigationItem.searchController = searchController
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
        return viewModel.countryCount
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
        
        let country = viewModel.country(index: indexPath.row)
        cell.configure(with: country)
        
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

    // MARK: - Routing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectCountry(at: indexPath.row)
    }
}

// MARK: - UISearchBarDelegate

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchBarTextDidChange(searchText)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.searchBarTextDidBeginEditing()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel.searchBarTextDidEndEditing()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel.searchBarCancelButtonClicked()
    }
}

extension MainViewController: MainViewModelDelegate{
    func notifyTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func notifyViewAfterSearchTextDidChange() {
        stackView.layoutIfNeeded()
        stackView.isHidden = true
        worldWideLabel.text = ""
        coronaImageView.isHidden = true

        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5.0).isActive = true
        tableView.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: 10.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5.0).isActive = true
    }

    func notifyViewAfterSearchDidEnd() {
        stackView.layoutIfNeeded()
        stackView.isHidden = false
        worldWideLabel.isHidden = false
        coronaImageView.isHidden = false
    }

    func prepareWorldViewInfos(_ presentation: GlobalPresentation) {
        worldCasesLabel.text = presentation.worldCasesLabelText
        worldDeathsLabel.text = presentation.worldDeathsLabelText
        worldRecoveredLabel.text = presentation.worldRecoveredLabelText
        worldUpdatedLabel.text = presentation.worldUpdatedLabelText
        worldActiveLabel.text = presentation.worldActiveLabelText
        worldAffectedCountriesLabel.text = presentation.worldAffectedCountriesLabelText
    }
    func navigate(to route: MainViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = MainDetailControllerBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }

}
