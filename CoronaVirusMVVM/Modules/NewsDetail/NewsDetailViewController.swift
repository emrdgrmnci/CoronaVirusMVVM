//
//  NewsDetailViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 14.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import Foundation
import WebKit

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var detailViewModel: NewsDetailViewModelInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
         title = "NEWS"
        detailViewModel.delegate = self
        detailViewModel.load()
    }
}

extension NewsDetailViewController: NewsDetailViewModelDelegate {
    func prepareDetailViewInfos(_ presentation: NewsDetailPresentation) {
        guard let detailURL = URL(string: presentation.newsDetailURL) else { return }
        webView.load(URLRequest(url: detailURL))
    }
}
