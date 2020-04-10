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

class NewsViewController: UIViewController {

    private var articleListVM : ArticleListViewModel!

    let apiKey = Constants.shared.newsApiKey

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "NEWS"

        tableView.delegate = self
        tableView.dataSource = self

        getNews()
    }

    func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setStatusBar(backgroundColor: UIColor(displayP3Red: 32/255, green: 200/255, blue: 182/255, alpha: 1))
    }

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

extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfRowSection(section)

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Cell error")
        }

        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)

        cell.newsImageView.sd_setImage(with: URL(string: "\(String(describing: articleVM.urlToImage))"), placeholderImage: UIImage(named: "placeholder.png"))
        cell.newsContentLabel.text = articleVM.title
        cell.newsSourceLabel.text = articleVM.source
        cell.newsPublishedLabel.text = formattedDate(of: articleVM.publishedAt)

        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        routeToDetail(with: indexPath.row)
    }
}

extension NewsViewController {
    func routeToDetail(with row: Int) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let detailVC = storyboard.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController else { return }

        let articleDetailVM = articleListVM.articleAtIndex(row)
        detailVC.configure(with: articleDetailVM)

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
