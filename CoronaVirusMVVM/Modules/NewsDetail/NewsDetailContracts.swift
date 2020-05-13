//
//  NewsDetailContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 13.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

protocol NewsDetailViewModelDelegate: class {
     func prepareDetailViewInfos(_ presentation: CountryDetailPresentation)

}

protocol NewsDetailViewModelInterface: class {
    var delegate: NewsDetailViewModelDelegate? { get set }
    func load()
}

