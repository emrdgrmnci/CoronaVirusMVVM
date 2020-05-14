//
//  NewsDetailControllerBuilder.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 14.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit

final class NewsDetailControllerBuilder {

    static func make(with viewModel: NewsDetailViewModelInterface) -> NewsDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        viewController.detailViewModel = viewModel
        return viewController
    }
}
