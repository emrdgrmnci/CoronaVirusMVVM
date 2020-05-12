//
//  MainDetailContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 12.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

protocol MainDetailViewModelDelegate: class {
     func prepareDetailViewInfos(_ presentation: CountryDetailPresentation)

}

protocol MainDetailViewModelInterface: class {
    var delegate: MainDetailViewModelDelegate? { get set }
    func load()
//    func country(index: Int) -> Country
//    func getCountryDetails()

//    func viewWillDisappear()
}

