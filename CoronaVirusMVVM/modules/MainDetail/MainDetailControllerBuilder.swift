//
//  MainDetailControllerBuilder.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 12.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

final class MainDetailControllerBuilder {

    static func make(with viewModel: MovieDetailViewModelProtocol) -> MainDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainDetailViewController") as! MainDetailViewController
        viewController.viewModel = viewModel
        return viewController
    }
}
