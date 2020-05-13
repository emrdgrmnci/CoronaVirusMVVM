//
//  NewsListContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 13.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

protocol NewsViewModelInterface: class {
    var delegate: MainViewModelDelegate? { get set }
    var newsCount: Int { get }

    func article(index: Int) -> News
    func getAllNews()

    func viewWillDisappear()
}

protocol NewsViewModelDelegate: class {
    func notifyTableView()
    func prepareNewsViewInfos(_ presentation: GlobalPresentation)
    func navigate(to route: NewViewRoute)
}

enum NewViewRoute {
    case detail(NewsViewModelInterface)
}
