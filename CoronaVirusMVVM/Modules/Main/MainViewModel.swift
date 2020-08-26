//
//  MainViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ahmet Keskin on 10.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    private let service: APIServiceProtocol
    
    var countries: [Country]
    var filteredCountries: [Country]
    
    var isSearching: Bool = false

    //Dependency Injection
    init(service: APIServiceProtocol) {
        self.service = service
        self.countries = []
        self.filteredCountries = []
    }
    
}

extension MainViewModel: MainViewModelInterface {
    func selectCountry(at index: Int) {
        if isSearching {
            let searchDetail = filteredCountries[index]
            let viewModel = MainDetailViewModel(countryDetail: searchDetail)
            delegate?.navigate(to: .detail(viewModel))
        } else {
            let countryDetail = countries[index]
            let viewModel = MainDetailViewModel(countryDetail: countryDetail)
            delegate?.navigate(to: .detail(viewModel))
        }
    }

    var countryCount: Int {
        return isSearching ? filteredCountries.count : countries.count
    }
    
    func country(index: Int) -> Country {
        return isSearching ? filteredCountries[index] : countries[index]
    }

    // MARK - Lifcycle Methods
    func viewWillDisappear() {
        isSearching = false
        delegate?.notifyTableView()
    }
    
    // MARK - SearchBar
    func searchBarTextDidChange(_ searchText: String) {
        filteredCountries.removeAll()
        isSearching = searchText != ""
        filteredCountries = countries.filter({ $0.country!.prefix(searchText.count) == searchText })
        delegate?.notifyTableView()
        delegate?.notifyViewAfterSearchTextDidChange()
    }
    
    func searchBarTextDidBeginEditing() {
        delegate?.notifyViewAfterSearchTextDidChange()
    }
    
    func searchBarTextDidEndEditing() {
        delegate?.notifyViewAfterSearchDidEnd()
        delegate?.notifyTableView()
    }
    
    func searchBarCancelButtonClicked() {
        delegate?.notifyViewAfterSearchDidEnd()
        isSearching = false
        delegate?.notifyTableView()
    }
    
    // MARK - Network Calls
    func getAllCountries() {
        let url = URL(string: "https://corona.lmao.ninja/v2/countries?sort=country")!
        service.getCountries(url: url) { [weak self] (countries) in
            self?.countries = countries?.reversed() ?? []
            self?.delegate?.notifyTableView()
        }
    }
    
    func getAllCases() {
        let url = URL(string: "https://corona.lmao.ninja/v2/all")!
        service.getGlobalCases(url: url) { [weak self] (global) in
            guard let global = global else { return }
            let presentation = GlobalPresentation.init(global: global)
            DispatchQueue.main.async {
                self?.delegate?.prepareWorldViewInfos(presentation)
            }
        }
    }
}


