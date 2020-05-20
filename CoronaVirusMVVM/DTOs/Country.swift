//
//  Country.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 2.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

 struct Country: Codable {
    let country: String?
    let countryInfo: CountryInfo?
    let cases: Int?
    let todayCases: Int?
    let deaths: Int?
    let todayDeaths: Int?
    let recovered: Int?
    let active: Int?
    let critical: Int?
    let casesPerOneMillion: Double?
    let deathsPerOneMillion: Double?
    let updated: Int?
}

struct CountryInfo: Codable {
    let flag: String?
}
