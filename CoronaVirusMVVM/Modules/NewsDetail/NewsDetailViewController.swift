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

    @IBOutlet weak var webView: WKWebView!

    var detailViewModel: NewsDetailViewModelInterface!
    private var networkReachability = NetworkReachability()

    // MARK: - View's Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        //MARK: - NetworkReachability
        if !networkReachability.isReachable {
            let alert = UIAlertController(title: "Oops!", message: "You're offline! Check your network connection.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        detailViewModel.delegate = self
        detailViewModel.load()

    }
}

extension NewsDetailViewController: NewsDetailViewModelDelegate {
    func prepareDetailViewInfos(_ presentation: NewsDetailPresentation) {
        guard let url = URL(string: presentation.newsURL) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
