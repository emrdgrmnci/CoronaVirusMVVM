//
//  NewsDetailViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 10.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import UIKit
import Foundation
import SafariServices
import WebKit

class NewsDetailViewController: UIViewController {

    private var articleViewModel: ArticleViewModel!

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = articleViewModel.source

        guard let url = URL(string: self.articleViewModel.url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)

    }

    // MARK: - Configuration
    public func configure(with viewModel: ArticleViewModel) {
        self.articleViewModel = viewModel
    }
}
