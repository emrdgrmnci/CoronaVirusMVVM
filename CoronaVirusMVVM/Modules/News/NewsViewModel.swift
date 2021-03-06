//
//  NewsViewModel.swift
//  CoronaVirusMVVM
//
//  Created by Ali Emre Değirmenci on 14.05.2020.
//  Copyright © 2020 Ali Emre Degirmenci. All rights reserved.
//

import Foundation

class NewsViewModel {

    let apiKey = Constants.shared.newsApiKey

    weak var delegate: NewsViewModelDelegate?
    private let service: APIServiceProtocol

    var news: [News]

    init(service: APIServiceProtocol) {
        self.service = service
        self.news = []
    }

}

extension NewsViewModel: NewsViewModelInterface {
    func selectNews(at index: Int) {
        let newsDetail = news[index]
        let viewModel = NewsDetailViewModel(newsDetail: newsDetail)
        delegate?.navigate(to: .detail(viewModel))
    }

    var newsCount: Int {
        return news.count
    }

    func news(index: Int) -> News {
        return news[index]
    }

    func getAllNews() {
        let url = URL(string: "http://newsapi.org/v2/everything?q=corona&sortBy=publishedAt&apiKey=\(apiKey)")!
        service.getNews(url: url) { [weak self] (news) in
            self?.news = news?.news ?? []
            self?.delegate?.notifyTableView()
        }
    }

    func viewWillDisappear() {
        delegate?.notifyTableView() 
    }
}


