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
        let url = URL(string: "https://www.hackingwithswift.com")!
        webView.load(URLRequest(url: url))
    }
}
