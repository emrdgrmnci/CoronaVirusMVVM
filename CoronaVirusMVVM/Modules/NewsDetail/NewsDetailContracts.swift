//
//  NewsDetailContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 14.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

protocol NewsDetailViewModelDelegate: class {
     func prepareDetailViewInfos(_ presentation: NewsDetailPresentation)
}

protocol NewsDetailViewModelInterface: class {
    var delegate: NewsDetailViewModelDelegate? { get set }
    func load()
}
