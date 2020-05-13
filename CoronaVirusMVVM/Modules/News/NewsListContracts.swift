//
//  NewsListContracts.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 13.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

protocol NewsViewModelInterface: class {
    var delegate: NewsViewModelDelegate? { get set }
    var newsCount: Int { get }
    func selectNews(at index: Int)

    func news(index: Int) -> News
    func getAllNews()

    func viewWillDisappear()
}

protocol NewsViewModelDelegate: class {
    func notifyTableView()
//    func prepareNewsViewInfos(_ presentation: NewsDetailPresentation)
    func navigate(to route: NewsViewRoute)
}

enum NewsViewRoute {
    case detail(NewsDetailViewModelInterface)
}
