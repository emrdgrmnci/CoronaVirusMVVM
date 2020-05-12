//
//  MainDetailContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 12.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

protocol MainDetailViewModelDelegate: class {
    func showDetail(_ presentation: MovieDetailPresentation)
}

protocol MainDetailViewModelProtocol {
    var delegate: MainDetailViewModelDelegate? { get set }
    func load()
}
