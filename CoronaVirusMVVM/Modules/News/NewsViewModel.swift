//
//  NewsViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 13.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

class NewsViewModel {

    weak var delegate: NewsViewModelDelegate?
    private let service: APIServiceProtocol

    var news: [News]

    init(service: APIServiceProtocol) {
        self.service = service
        self.news = []
    }
}

extension NewsViewModel: NewsViewModelInterface {
    func selectCountry(at index: Int) {
        let countryDetail = countries[index]
        let viewModel = MainDetailViewModel(countryDetail: countryDetail)
        delegate?.navigate(to: .detail(viewModel))
    }


    var countryCount: Int {
        return isSearching ? filteredCountries.count : countries.count
    }

    func country(index: Int) -> Country {
        return isSearching ? filteredCountries[index] : countries[index]
    }

    // MARK - Lifcycle Methods
    func viewWillDisappear() {
        delegate?.notifyTableView()
    }

    // MARK - Network Calls
    func getAllCountries() {
        let url = URL(string: "https://corona.lmao.ninja/v2/countries?sort=country")!
        service.getCountries(url: url) { [weak self] (countries) in
            self?.countries = countries ?? []
            self?.delegate?.notifyTableView()
        }
    }

    func getAllCases() {
        let url = URL(string: "https://corona.lmao.ninja/v2/all")!
        service.getGlobalCases(url: url) { (global) in
            guard let global = global else { return }
            let presentation = GlobalPresentation.init(global: global)
            DispatchQueue.main.async {
                self.delegate?.prepareWorldViewInfos(presentation)
            }
        }
    }
}


