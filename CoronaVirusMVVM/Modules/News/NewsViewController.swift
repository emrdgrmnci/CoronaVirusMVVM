//
//  NewsViewController.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 10.04.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

class NewsViewController: UIViewController {

    private var articleListVM : ArticleListViewModel!

    let apiKey = Constants.shared.newsApiKey
    private var shouldAnimate = true
    private var networkReachability = NetworkReachability()

    @IBOutlet weak var tableView: UITableView!

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

        title = "NEWS"
        tableView.delegate = self
        tableView.dataSource = self

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.shouldAnimate = false
            self.tableView.reloadData()
        }

        getNews()
    }

    // MARK: - NavigationBar

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setStatusBar(backgroundColor: UIColor(displayP3Red: 32/255, green: 200/255, blue: 182/255, alpha: 1))
    }

    // MARK: - Requests

    func getNews() {
        let url = URL(string: "http://newsapi.org/v2/everything?q=corona&sortBy=publishedAt&apiKey=\(apiKey)")!
        APIService().getNews(url: url) { [weak self] articles in

            guard let self = self,
                let articles = articles else { return }

            self.articleListVM = ArticleListViewModel(articles: articles)

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }
    }

    public func formattedDate(of publishedAt: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let publishedDate = formatter.date(from: publishedAt)
        formatter.dateFormat = "dd-MMMM-yyyy"
        let formattedDate = formatter.string(from: publishedDate!)
        return formattedDate
    }
}

// MARK: - UITableViewDataSource

extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfRowSection(section)

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Cell error")
        }

        if shouldAnimate {
            cell.showAnimatedGradientSkeleton()
        } else {
            cell.hideAnimation()
        }

        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)

        cell.newsImageView.sd_setImage(with: URL(string: "\(String(describing: articleVM.urlToImage))"), placeholderImage: UIImage(named: "placeholder.png"))
        cell.newsContentLabel.text = articleVM.title
        cell.newsSourceLabel.text = articleVM.source
        cell.newsPublishedLabel.text = formattedDate(of: articleVM.publishedAt)
        cell.hideAnimation()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        routeToDetail(with: indexPath.row)
    }
}

// MARK: - Routing

extension NewsViewController {
    func routeToDetail(with row: Int) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController else { return }

        let articleDetailVM = articleListVM.articleAtIndex(row)
        detailVC.configure(with: articleDetailVM)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
