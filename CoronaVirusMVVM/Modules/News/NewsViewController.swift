//
//  NewsViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 14.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

class NewsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: NewsViewModelInterface! {
        didSet {
            viewModel.delegate = self
        }
    }

    private var shouldAnimate = true
    private var networkReachability = NetworkReachability()

    // MARK: - View's Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        networkControl()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NEWS"
        tableView.delegate = self
        tableView.dataSource = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.shouldAnimate = false
            self.tableView.reloadData()
        }

        viewModel.getAllNews()

        setupNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }

    //MARK: - NetworkReachability
    func networkControl() {
        if !networkReachability.isReachable {
            let alert = UIAlertController(title: "Oops!", message: "You're offline! Check your network connection.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - NavigationBar
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setStatusBar(backgroundColor: UIColor(displayP3Red: 32/255, green: 200/255, blue: 182/255, alpha: 1))
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("NewsTableViewCell not found")
        }

        if shouldAnimate {
            cell.showAnimatedGradientSkeleton()
        } else {
            cell.hideAnimation()
        }

        let news = viewModel.news(index: indexPath.row)
        cell.configure(with: news)

        return cell
    }
}

// MARK: - SkeletonViewTableViewDataSource
extension NewsViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "NewsTableViewCell"
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    // MARK: - Routing
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectNews(at: indexPath.row)
    }
}

extension NewsViewController: NewsViewModelDelegate{
    func notifyTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func navigate(to route: NewsViewRoute) {
        switch route {
        case .detail(let viewModel):
            let viewController = NewsDetailControllerBuilder.make(with: viewModel)
            show(viewController, sender: nil)
        }
    }
}
