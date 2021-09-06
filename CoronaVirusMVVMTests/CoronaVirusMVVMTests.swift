//
//  CoronaVirusMVVMTests.swift
//  CoronaVirusMVVMTests
//
//  Created by Ali Emre Değirmenci on 20.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import XCTest
@testable import CoronaVirusMVVM

class CoronaVirusMVVMTests: XCTestCase {
    
//    private var viewModel: MainViewModel!
//    private var apiService: APIService!
//
//    override func setUp() {
//        apiService = APIService()
//        viewModel = .init(service: apiService)
//    }

    func testCoronaCountrySpecificData() throws {
        guard let path = Bundle(for: type(of: self)).path(forResource: "corona", ofType: "json") else {
            fatalError("json not found!")
        }

        guard let json = try? String(contentsOfFile: path, encoding: .utf8) else {
            fatalError("Unable to convert json to String!")
        }

        guard let jsonData = json.data(using: .utf8) else { return }
        let corona = try! JSONDecoder().decode(Country.self, from: jsonData)

        XCTAssertEqual(corona.deaths, 58106)
        XCTAssertEqual(corona.critical, 633)
        XCTAssertEqual(corona.deathsPerOneMillion, 680)

        let test = Country(country: "Turkey", countryInfo: CountryInfo(flag: ""), cases: 0, todayCases: 0, deaths: 58106, todayDeaths: 0, recovered: 0, active: 0, critical: 633, casesPerOneMillion: 0.0, deathsPerOneMillion: 680, updated: 0)
        let api = APIService()
        let viewModel = MainViewModel(service: api)
        let list = viewModel.countries

//        XCTAssertEqual(test.country, list[1].country)
    }
}
