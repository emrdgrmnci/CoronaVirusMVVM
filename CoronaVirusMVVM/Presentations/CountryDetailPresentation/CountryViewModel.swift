//
//  CountryViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 11.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct CountryListPresentation {

    var countryList: [Country]

    // MARK: - TableView Helpers

    func numberOfRowsInSection(_ section: Int) -> Int {
        return countryList.count
    }

    func countryAtIndex(_ index: Int) -> CountryViewModel {
        return CountryViewModel(countryInfo: countryList[index])
    }

    func searchedCountryAtIndex(_ index: Int) -> CountryViewModel {
        return CountryViewModel(countryInfo: countryList[index])
    }
}

struct CountryViewModel {

    let countryInfo: Country

    // MARK: - Helpers

    var country: String {
        return countryInfo.country!
    }

    var cases: Int {
        return countryInfo.cases!
    }

    var todayCases: Int {
        return countryInfo.todayCases!
    }

    var deaths: Int {
        return countryInfo.deaths!
    }

    var todayDeaths: Int {
        return countryInfo.todayDeaths!
    }

    var recovered: Int {
        return countryInfo.recovered!
    }

    var active: Int {
        return countryInfo.active!
    }

    var critical: Int {
        return countryInfo.critical!
    }

    var casesPerOneMillion: Double {
        return countryInfo.casesPerOneMillion!
    }

    var deathsPerOneMillion: Double {
        return countryInfo.deathsPerOneMillion!
    }

    var countryFlag: String {
        return (countryInfo.countryInfo?.flag)!
     }
}
