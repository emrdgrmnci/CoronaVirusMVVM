//
//  MainListContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 12.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

// View tarafından ViewModel'a göndermemiz gerekenler
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

// notify metotları
protocol MainViewModelDelegate: class {
    func notifyTableView()//TableView reload data
    func notifyViewAfterSearchTextDidChange()// search başlayınca stackViewu gizle tableViewu full ekran göster
    func notifyViewAfterSearchDidEnd()// search bitince stackViewu göster tableViewu full ekran göster
    func prepareWorldViewInfos(_ presentation: GlobalPresentation)
    func navigate(to route: MainViewRoute)//mainview'dan detail ekranına geçiş esnasında taşınan veriler için
}

enum MainViewRoute {
    case detail(MainDetailViewModelInterface)
}



