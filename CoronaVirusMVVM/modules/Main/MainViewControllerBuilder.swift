//
//  MainViewControllerBuilder.swift
//  CoronaVirusMVVM
//
//  Created by Ahmet Keskin on 10.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

class MainViewControllerBuilder {
    static func make() -> MainViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let view = storyBoard.instantiateViewController(identifier: "MainViewController") as! MainViewController
        let service = APIService()
        let viewModel = MainViewModel(service: service)
        view.viewModel = viewModel
        
        return view
    }
}
