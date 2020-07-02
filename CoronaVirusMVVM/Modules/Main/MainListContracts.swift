//
//  MainContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 12.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

protocol MainViewModelInterface: class {
    var delegate: MainViewModelDelegate? { get set }
    var countryCount: Int { get }
    func selectCountry(at index: Int)

    func country(index: Int) -> Country
    func getAllCountries()
    func getAllCases()

    func searchBarTextDidChange(_ searchText: String)
    func searchBarTextDidBeginEditing()
    func searchBarTextDidEndEditing()
    func searchBarCancelButtonClicked()

    func viewWillDisappear()
}

protocol MainViewModelDelegate: class {
    func notifyTableView()
    func notifyViewAfterSearchTextDidChange()
    func notifyViewAfterSearchDidEnd()
    func prepareWorldViewInfos(_ presentation: GlobalPresentation)
    func navigate(to route: MainViewRoute)
}

enum MainViewRoute {
    case detail(MainDetailViewModelInterface)
}



