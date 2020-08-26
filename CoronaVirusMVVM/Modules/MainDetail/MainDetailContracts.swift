//
//  MainDetailContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 12.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

// Detailed data presentation
protocol MainDetailViewModelDelegate: class {
     func prepareDetailViewInfos(_ presentation: MainDetailPresentation)

}

protocol MainDetailViewModelInterface: class {
    var delegate: MainDetailViewModelDelegate? { get set }
    func load()
}

