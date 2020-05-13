//
//  NewsViewControllerBuilder.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 13.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit

final class NewsViewControllerBuilder {
    static func make(with viewModel: MainDetailViewModelInterface) -> NewsDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as! NewsDetailViewController
        viewController.detailViewModel = viewModel
        return viewController
    }
}
