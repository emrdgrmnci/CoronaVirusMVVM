//
//  NewsViewControllerBuilder.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 14.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class NewsViewControllerBuilder {
    static func make() -> NewsViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let view = storyBoard.instantiateViewController(identifier: "NewsViewController") as! NewsViewController
        let service = APIService()
        let viewModel = NewsViewModel(service: service)
        view.viewModel = viewModel
        return view
    }
}
