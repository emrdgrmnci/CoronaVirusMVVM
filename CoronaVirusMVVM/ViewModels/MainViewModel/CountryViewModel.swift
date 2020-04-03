//
//  CountryViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

struct CountryListViewModel {
    let countryList: [Country]
}

extension CountryListViewModel {
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.countryList.count
    }

    func countryAtIndex(_ index: Int) -> CountryViewModel {
        let country = self.countryList[index]
    return CountryViewModel(countryInfo: country)
    }
}

struct CountryViewModel {
     let countryInfo: Country
}

extension CountryViewModel {
    init(_ countryInfo: Country) {
        self.countryInfo = countryInfo
    }
}

extension CountryViewModel {
    var country: String {
        return self.countryInfo.country!
    }
    var cases: Int {
        return self.countryInfo.cases!
    }
    var todayCases: Int {
        return self.countryInfo.todayCases!
    }
    var deaths: Int {
        return self.countryInfo.deaths!
    }
    var todayDeaths: Int {
        return self.countryInfo.todayDeaths!
    }
    var recovered: Int {
        return self.countryInfo.recovered!
    }
    var active: Int {
        return self.countryInfo.active!
    }
    var critical: Int {
        return self.countryInfo.critical!
    }
    var casesPerOneMillion: Double {
        return self.countryInfo.casesPerOneMillion!
    }
    var deathsPerOneMillion: Double {
        return self.countryInfo.deathsPerOneMillion!
    }
    var countryFlag: String {
        return (self.countryInfo.countryInfo?.flag!)!
     }
}
